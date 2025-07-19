import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:image/image.dart' as img;

enum GestureType { none, thumbsUp, openPalm, fist, peace }

enum ConnectionStatus { disconnected, connecting, connected, error }

class GestureResult {
  final GestureType gesture;
  final double confidence;
  final DateTime timestamp;

  GestureResult({
    required this.gesture,
    required this.confidence,
    required this.timestamp,
  });
}

class GestureWebSocketService {
  static final GestureWebSocketService _instance =
      GestureWebSocketService._internal();
  factory GestureWebSocketService() => _instance;
  GestureWebSocketService._internal();

  WebSocketChannel? _channel;
  StreamController<GestureResult>? _gestureController;
  StreamController<ConnectionStatus>? _statusController;
  Timer? _reconnectTimer;
  Timer? _pingTimer;

  String _serverUrl = '';
  bool _isConnecting = false;
  int _frameId = 0;
  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;

  // Configuration
  static const int _reconnectDelay = 3; // seconds
  static const int _pingInterval = 5; // seconds
  static const int _frameSkipRate = 3; // Send every 3rd frame
  int _frameSkipCounter = 0;

  Stream<GestureResult> get gestureStream =>
      _gestureController?.stream ?? const Stream.empty();

  Stream<ConnectionStatus> get statusStream =>
      _statusController?.stream ?? const Stream.empty();

  ConnectionStatus get currentStatus => _currentStatus;
  bool get isConnected => _currentStatus == ConnectionStatus.connected;

  Future<void> initialize(String serverIp) async {
    _serverUrl = 'ws://$serverIp:8000/ws';

    _gestureController = StreamController<GestureResult>.broadcast();
    _statusController = StreamController<ConnectionStatus>.broadcast();

    print('🔗 Gesture WebSocket Service initialized with server: $_serverUrl');
  }

  Future<void> connect() async {
    if (_isConnecting || isConnected) return;

    _isConnecting = true;
    _updateStatus(ConnectionStatus.connecting);

    try {
      print('🔌 Connecting to gesture server: $_serverUrl');

      _channel = WebSocketChannel.connect(Uri.parse(_serverUrl));

      // Wait for connection to be established
      await _channel!.ready;

      _updateStatus(ConnectionStatus.connected);
      _isConnecting = false;

      print('✅ Connected to gesture server');

      // Start listening to messages
      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnection,
      );

      // Start ping timer to keep connection alive
      _startPingTimer();
    } catch (e) {
      print('❌ Failed to connect to gesture server: $e');
      _isConnecting = false;
      _updateStatus(ConnectionStatus.error);
      _scheduleReconnect();
    }
  }

  void disconnect() {
    print('🔌 Disconnecting from gesture server');

    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
    _channel?.sink.close();
    _channel = null;

    _updateStatus(ConnectionStatus.disconnected);
  }

  Future<void> sendFrame(CameraImage cameraImage) async {
    if (!isConnected) return;

    // Skip frames to reduce bandwidth
    _frameSkipCounter++;
    if (_frameSkipCounter < _frameSkipRate) return;
    _frameSkipCounter = 0;

    try {
      // Convert CameraImage to JPEG bytes
      final jpegBytes = await _convertCameraImageToJpeg(cameraImage);
      if (jpegBytes == null) return;

      // Encode to base64
      final base64Image = base64Encode(jpegBytes);

      // Create message
      final message = {
        'type': 'frame',
        'data': base64Image,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'frame_id': _frameId++,
      };

      // Send to server
      _channel?.sink.add(jsonEncode(message));
    } catch (e) {
      print('❌ Error sending frame: $e');
    }
  }

  Future<void> sendBase64Frame(String base64Image) async {
    if (!isConnected) return;

    try {
      // Create message
      final message = {
        'type': 'frame',
        'data': base64Image,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'frame_id': _frameId++,
      };

      // Send to server
      _channel?.sink.add(jsonEncode(message));
    } catch (e) {
      print('❌ Error sending base64 frame: $e');
    }
  }

  Future<Uint8List?> _convertCameraImageToJpeg(CameraImage cameraImage) async {
    try {
      final int width = cameraImage.width;
      final int height = cameraImage.height;

      // Check if we have enough planes
      if (cameraImage.planes.isEmpty) {
        print('❌ No image planes available');
        return null;
      }

      print(
        '📷 Camera format: ${cameraImage.format.group}, planes: ${cameraImage.planes.length}',
      );

      // Handle different image formats
      if (cameraImage.format.group == ImageFormatGroup.yuv420) {
        return _convertYUV420ToJpeg(cameraImage);
      } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
        return _convertBGRA8888ToJpeg(cameraImage);
      } else {
        // Fallback: try to use the first plane as grayscale
        return _convertSinglePlaneToJpeg(cameraImage);
      }
    } catch (e) {
      print('❌ Error converting camera image: $e');
      return null;
    }
  }

  Future<Uint8List?> _convertYUV420ToJpeg(CameraImage cameraImage) async {
    try {
      final int width = cameraImage.width;
      final int height = cameraImage.height;

      if (cameraImage.planes.length < 3) {
        print('❌ Not enough planes for YUV420: ${cameraImage.planes.length}');
        return null;
      }

      final Uint8List yPlane = cameraImage.planes[0].bytes;
      final Uint8List uPlane = cameraImage.planes[1].bytes;
      final Uint8List vPlane = cameraImage.planes[2].bytes;

      // Create RGB image
      final img.Image image = img.Image(width: width, height: height);

      int yIndex = 0;
      int uvIndex = 0;

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          if (yIndex >= yPlane.length) break;

          final int yValue = yPlane[yIndex];
          final int uValue =
              uvIndex < uPlane.length ? uPlane[uvIndex ~/ 2] : 128;
          final int vValue =
              uvIndex < vPlane.length ? vPlane[uvIndex ~/ 2] : 128;

          // YUV to RGB conversion
          int r = (yValue + 1.402 * (vValue - 128)).round().clamp(0, 255);
          int g = (yValue -
                  0.344136 * (uValue - 128) -
                  0.714136 * (vValue - 128))
              .round()
              .clamp(0, 255);
          int b = (yValue + 1.772 * (uValue - 128)).round().clamp(0, 255);

          image.setPixelRgb(x, y, r, g, b);

          yIndex++;
          if (x % 2 == 1) uvIndex++;
        }
        if (y % 2 == 1) uvIndex = (y ~/ 2 + 1) * width;
      }

      // Resize to reduce bandwidth
      final resized = img.copyResize(image, width: 320, height: 240);

      // Encode as JPEG
      return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
    } catch (e) {
      print('❌ Error converting YUV420: $e');
      return null;
    }
  }

  Future<Uint8List?> _convertBGRA8888ToJpeg(CameraImage cameraImage) async {
    try {
      final int width = cameraImage.width;
      final int height = cameraImage.height;
      final Uint8List bytes = cameraImage.planes[0].bytes;

      // Create RGB image from BGRA
      final img.Image image = img.Image(width: width, height: height);

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final int pixelIndex = (y * width + x) * 4;
          if (pixelIndex + 3 < bytes.length) {
            final int b = bytes[pixelIndex];
            final int g = bytes[pixelIndex + 1];
            final int r = bytes[pixelIndex + 2];
            // Skip alpha channel (bytes[pixelIndex + 3])

            image.setPixelRgb(x, y, r, g, b);
          }
        }
      }

      // Resize to reduce bandwidth
      final resized = img.copyResize(image, width: 320, height: 240);

      // Encode as JPEG
      return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
    } catch (e) {
      print('❌ Error converting BGRA8888: $e');
      return null;
    }
  }

  Future<Uint8List?> _convertSinglePlaneToJpeg(CameraImage cameraImage) async {
    try {
      final int width = cameraImage.width;
      final int height = cameraImage.height;
      final Uint8List bytes = cameraImage.planes[0].bytes;

      // Create grayscale image
      final img.Image image = img.Image(width: width, height: height);

      int byteIndex = 0;
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          if (byteIndex < bytes.length) {
            final int gray = bytes[byteIndex];
            image.setPixelRgb(x, y, gray, gray, gray);
            byteIndex++;
          }
        }
      }

      // Resize to reduce bandwidth
      final resized = img.copyResize(image, width: 320, height: 240);

      // Encode as JPEG
      return Uint8List.fromList(img.encodeJpg(resized, quality: 70));
    } catch (e) {
      print('❌ Error converting single plane: $e');
      return null;
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);

      if (data['type'] == 'gesture') {
        final gestureStr = data['gesture'] as String;
        final confidence = (data['confidence'] as num).toDouble();

        final gesture = _parseGesture(gestureStr);
        final result = GestureResult(
          gesture: gesture,
          confidence: confidence,
          timestamp: DateTime.now(),
        );

        _gestureController?.add(result);

        // Log significant gestures
        if (gesture != GestureType.none && confidence > 0.7) {
          print(
            '👋 Detected gesture: $gestureStr (${(confidence * 100).toInt()}%)',
          );
        }
      }
    } catch (e) {
      print('❌ Error handling message: $e');
    }
  }

  GestureType _parseGesture(String gestureStr) {
    switch (gestureStr.toLowerCase()) {
      case 'thumbs_up':
        return GestureType.thumbsUp;
      case 'open_palm':
        return GestureType.openPalm;
      case 'fist':
        return GestureType.fist;
      case 'peace':
        return GestureType.peace;
      default:
        return GestureType.none;
    }
  }

  void _handleError(error) {
    print('❌ WebSocket error: $error');
    _updateStatus(ConnectionStatus.error);
    _scheduleReconnect();
  }

  void _handleDisconnection() {
    print('🔌 WebSocket disconnected');
    _channel = null;
    _updateStatus(ConnectionStatus.disconnected);
    _scheduleReconnect();
  }

  void _updateStatus(ConnectionStatus status) {
    if (_currentStatus != status) {
      _currentStatus = status;
      _statusController?.add(status);
    }
  }

  void _scheduleReconnect() {
    if (_reconnectTimer?.isActive == true) return;

    print('🔄 Scheduling reconnect in $_reconnectDelay seconds...');

    _reconnectTimer = Timer(Duration(seconds: _reconnectDelay), () {
      if (!isConnected) {
        connect();
      }
    });
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(Duration(seconds: _pingInterval), (timer) {
      if (isConnected) {
        final pingMessage = {
          'type': 'ping',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
        _channel?.sink.add(jsonEncode(pingMessage));
      } else {
        timer.cancel();
      }
    });
  }

  void dispose() {
    disconnect();
    _gestureController?.close();
    _statusController?.close();
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
  }
}
