import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:al_insan_app_front/services/video_queue.dart';
import 'package:al_insan_app_front/services/video_sync_service.dart';
import 'package:al_insan_app_front/services/gesture_websocket_service.dart';
import 'package:shake/shake.dart';

import 'dart:async';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  bool isRecording = false;
  String? videoPath;
  ShakeDetector? shakeDetector;
  Timer? _shakeTimer;
  bool _pendingShake = false;

  // WebSocket gesture detection
  GestureWebSocketService? _gestureService;
  StreamSubscription<GestureResult>? _gestureSubscription;
  StreamSubscription<ConnectionStatus>? _statusSubscription;
  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;
  GestureType _currentGesture = GestureType.none;
  bool _gestureDetectionEnabled = false;

  // Gesture cooldown to prevent rapid triggers
  DateTime _lastGestureTime = DateTime.now();
  static const Duration _gestureCooldown = Duration(
    milliseconds: 2000,
  ); // 2 second cooldown
  GestureType _lastProcessedGesture = GestureType.none;

  // Timer for capturing frames during recording
  Timer? _recordingGestureTimer;

  // Server IP (you can make this configurable)
  static const String _serverIp = '192.168.1.193';

  // Example list of Arabic names
  final List<String> names = [
    'محمد أحمد علي',
    'سارة يوسف',
    'خالد إبراهيم',
    'ليلى حسن',
    'عبدالله محمود',
    'فاطمة الزهراء',
    'ياسين عمر',
    'نور الدين',
    'جميلة سعيد',
    'سامي عبدالعزيز',
  ];

  int nameIndex = 0;
  static const int namesPerPage = 4;

  List<String> get currentNames {
    int end =
        (nameIndex + namesPerPage < names.length)
            ? nameIndex + namesPerPage
            : names.length;
    return names.sublist(nameIndex, end);
  }

  bool get hasNextPage => nameIndex + namesPerPage < names.length;

  void nextNames() {
    if (hasNextPage) {
      setState(() {
        nameIndex += namesPerPage;
      });
    }
  }

  void resetNames() {
    setState(() {
      nameIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initGestureDetection();
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: _onShake,
      shakeThresholdGravity: 3.0,
    );
  }

  Future<void> _initCamera() async {
    // Always use the front (selfie) camera for preview/recording
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => widget.cameras.first,
    );
    controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: true,
    );
    await controller!.initialize();

    // Start image stream for gesture detection if enabled
    if (_gestureDetectionEnabled && _gestureService?.isConnected == true) {
      controller!.startImageStream(_processImageForGestures);
    }

    setState(() {});
  }

  Future<void> _initGestureDetection() async {
    _gestureService = GestureWebSocketService();
    await _gestureService!.initialize(_serverIp);

    // Listen to gesture results
    _gestureSubscription = _gestureService!.gestureStream.listen((result) {
      setState(() {
        _currentGesture = result.gesture;
      });
      _handleGestureResult(result);
    });

    // Listen to connection status
    _statusSubscription = _gestureService!.statusStream.listen((status) {
      setState(() {
        _connectionStatus = status;
      });

      // Start/stop image stream based on connection
      if (status == ConnectionStatus.connected && _gestureDetectionEnabled) {
        _startGestureDetection();
      } else if (status == ConnectionStatus.disconnected) {
        _stopGestureDetection();
      }
    });
  }

  void _processImageForGestures(CameraImage image) {
    if (_gestureDetectionEnabled && _gestureService?.isConnected == true) {
      _gestureService!.sendFrame(image);
    }
  }

  void _handleGestureResult(GestureResult result) {
    // Only act on high-confidence gestures
    if (result.confidence < 0.8) return;

    // Check cooldown period to prevent rapid-fire gestures
    final now = DateTime.now();
    final timeSinceLastGesture = now.difference(_lastGestureTime);

    // If same gesture detected within cooldown period, ignore it
    if (result.gesture == _lastProcessedGesture &&
        timeSinceLastGesture < _gestureCooldown) {
      return;
    }

    // Update last gesture time and type
    _lastGestureTime = now;
    _lastProcessedGesture = result.gesture;

    print(
      '🎯 Processing gesture: ${result.gesture} (confidence: ${result.confidence})',
    );

    switch (result.gesture) {
      case GestureType.thumbsUp:
        if (!isRecording) {
          print('👍 Thumbs up detected - Starting recording');
          startVideoRecording();
        }
        break;
      case GestureType.openPalm:
        if (isRecording) {
          print('✋ Open palm detected - Stopping recording');
          stopVideoRecording();
        }
        break;
      case GestureType.fist:
        if (isRecording && hasNextPage) {
          print('✊ Fist detected - Next names');
          nextNames();
        }
        break;
      default:
        break;
    }
  }

  void _toggleGestureDetection() async {
    setState(() {
      _gestureDetectionEnabled = !_gestureDetectionEnabled;
    });

    if (_gestureDetectionEnabled) {
      await _gestureService!.connect();
    } else {
      _gestureService!.disconnect();
      _stopGestureDetection();
    }
  }

  void _startGestureDetection() {
    if (controller != null && controller!.value.isInitialized) {
      try {
        controller!.startImageStream(_processImageForGestures);
      } catch (e) {
        print('Error starting image stream: $e');
      }
    }
  }

  void _stopGestureDetection() {
    if (controller != null && controller!.value.isInitialized) {
      try {
        controller!.stopImageStream();
      } catch (e) {
        print('Error stopping image stream: $e');
      }
    }
  }

  void _startRecordingGestureDetection() {
    // Start periodic frame capture during recording (since image stream can't run during recording)
    _recordingGestureTimer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        if (!isRecording ||
            !_gestureDetectionEnabled ||
            _gestureService?.isConnected != true) {
          timer.cancel();
          return;
        }

        try {
          // Capture a single frame WITHOUT flash/screen blink
          final XFile imageFile = await controller!.takePicture();

          // Read the image file and convert to bytes
          final bytes = await imageFile.readAsBytes();

          // Send frame directly to gesture detection service as base64
          if (_gestureService?.isConnected == true) {
            final base64Image = base64Encode(bytes);
            await _gestureService!.sendBase64Frame(base64Image);
            print(
              '📸 Sent captured frame during recording for gesture detection',
            );
          }

          // Note: XFile cleanup is handled automatically by the system
        } catch (e) {
          print('⚠️ Error capturing frame during recording: $e');
        }
      },
    );

    print(
      '🎬 Started periodic gesture detection during recording (1 frame/sec)',
    );
  }

  void _stopRecordingGestureDetection() {
    _recordingGestureTimer?.cancel();
    _recordingGestureTimer = null;
    print('🛑 Stopped periodic gesture detection');
  }

  void _onShake() {
    if (_pendingShake) return; // Already waiting for sustained shake
    _pendingShake = true;
    _shakeTimer = Timer(const Duration(milliseconds: 1500), () async {
      _pendingShake = false;
      await _toggleRecording();
    });
  }

  Future<void> _toggleRecording() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (!isRecording) {
      // Start recording without flash
      await controller!.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } else {
      // Stop recording without flash
      await controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      await controller!.dispose();
      await Future.delayed(const Duration(milliseconds: 500));
      await _initCamera();
    }
  }

  Future<void> startVideoRecording() async {
    if (controller == null ||
        !controller!.value.isInitialized ||
        controller!.value.isRecordingVideo) {
      print(
        '❌ Cannot start recording: controller not ready or already recording',
      );
      return;
    }

    try {
      print('🎬 Starting video recording...');

      // Temporarily stop image stream before starting recording
      bool wasImageStreamRunning = false;
      if (_gestureDetectionEnabled && _gestureService?.isConnected == true) {
        try {
          await controller!.stopImageStream();
          wasImageStreamRunning = true;
          print('📷 Image stream temporarily stopped for recording start');
        } catch (e) {
          print('⚠️ Error stopping image stream: $e');
        }
      }

      await controller!.startVideoRecording();

      setState(() {
        isRecording = true;
        resetNames();
      });

      // Start periodic frame capture for gesture detection during recording
      if (wasImageStreamRunning &&
          _gestureDetectionEnabled &&
          _gestureService?.isConnected == true) {
        _startRecordingGestureDetection();
      }

      print(
        '✅ Video recording started successfully with gesture detection active',
      );
    } catch (e) {
      print('❌ Error starting video recording: $e');
      setState(() {
        isRecording = false;
      });
    }
  }

  Future<void> stopVideoRecording() async {
    if (controller == null || !controller!.value.isRecordingVideo) {
      print('❌ Cannot stop recording: not currently recording');
      return;
    }

    try {
      print('🛑 Stopping video recording...');

      // Stop periodic gesture detection first
      _stopRecordingGestureDetection();

      final XFile file = await controller!.stopVideoRecording();

      setState(() {
        isRecording = false;
        videoPath = file.path;
      });

      // Save to gallery
      await GallerySaver.saveVideo(file.path);

      // Restart image stream for gesture detection if enabled
      if (_gestureDetectionEnabled && _gestureService?.isConnected == true) {
        try {
          controller!.startImageStream(_processImageForGestures);
          print('📷 Image stream restarted for gesture detection');
        } catch (e) {
          print('⚠️ Error restarting image stream: $e');
        }
      }

      // Add to queue and trigger sync
      const userId = "USER_ID_HERE"; // Replace with actual user ID logic
      await VideoQueue.addToQueue(file.path, userId);
      await VideoSyncService.syncQueuedVideos();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video saved and queued for upload!')),
        );
      }

      print('✅ Video recording stopped and saved successfully');
    } catch (e) {
      print('❌ Error stopping video recording: $e');
      setState(() {
        isRecording = false;
      });

      // Stop gesture detection on error
      _stopRecordingGestureDetection();

      // Try to restart image stream even on error
      if (_gestureDetectionEnabled && _gestureService?.isConnected == true) {
        try {
          controller!.startImageStream(_processImageForGestures);
        } catch (streamError) {
          print(
            '⚠️ Error restarting image stream after recording error: $streamError',
          );
        }
      }
    }
  }

  // Helper methods for UI
  IconData _getConnectionIcon() {
    switch (_connectionStatus) {
      case ConnectionStatus.connected:
        return Icons.wifi;
      case ConnectionStatus.connecting:
        return Icons.wifi_find;
      case ConnectionStatus.error:
        return Icons.wifi_off;
      case ConnectionStatus.disconnected:
      default:
        return Icons.wifi_off;
    }
  }

  Color _getConnectionColor() {
    switch (_connectionStatus) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.connecting:
        return Colors.orange;
      case ConnectionStatus.error:
        return Colors.red;
      case ConnectionStatus.disconnected:
      default:
        return Colors.grey;
    }
  }

  String _getConnectionText() {
    if (!_gestureDetectionEnabled) {
      return 'Gesture Detection OFF';
    }

    switch (_connectionStatus) {
      case ConnectionStatus.connected:
        return 'Gesture Detection ON';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.error:
        return 'Connection Error';
      case ConnectionStatus.disconnected:
      default:
        return 'Disconnected';
    }
  }

  String _getGestureText(GestureType gesture) {
    switch (gesture) {
      case GestureType.thumbsUp:
        return 'Thumbs Up 👍';
      case GestureType.openPalm:
        return 'Open Palm ✋';
      case GestureType.fist:
        return 'Fist ✊';
      case GestureType.peace:
        return 'Peace ✌️';
      case GestureType.none:
      default:
        return 'None';
    }
  }

  @override
  void dispose() {
    shakeDetector?.stopListening();
    _shakeTimer?.cancel();
    _gestureSubscription?.cancel();
    _statusSubscription?.cancel();
    _gestureService?.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text('Selfie Camera')),
      body: Stack(
        children: [
          CameraPreview(controller!),
          // Connection status indicator (top-left)
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getConnectionIcon(),
                        color: _getConnectionColor(),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getConnectionText(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (_gestureDetectionEnabled &&
                      _currentGesture != GestureType.none)
                    Text(
                      'Gesture: ${_getGestureText(_currentGesture)}',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Gesture detection toggle button (top-right)
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: _toggleGestureDetection,
              backgroundColor:
                  _gestureDetectionEnabled ? Colors.green : Colors.grey,
              child: Icon(
                _gestureDetectionEnabled
                    ? Icons.gesture
                    : Icons.gesture_outlined,
                color: Colors.white,
              ),
            ),
          ),
          // Gesture instructions (bottom, when not recording)
          if (!isRecording && _gestureDetectionEnabled)
            Positioned(
              bottom: 100,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _connectionStatus == ConnectionStatus.connected
                          ? 'Gesture Controls:'
                          : 'Shake Controls:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _connectionStatus == ConnectionStatus.connected
                          ? '👍 Thumbs Up - Start Recording\n✋ Open Palm - Stop Recording\n✊ Fist - Next Names'
                          : '📱 Shake Phone - Start/Stop Recording',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          if (isRecording)
            Container(
              color: Colors.white.withValues(alpha: 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...currentNames.map(
                            (name) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Text(
                                name,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 110),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${(nameIndex / namesPerPage).ceil() + 1} / ${(names.length / namesPerPage).ceil()}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 32),
                              if (hasNextPage)
                                ElevatedButton(
                                  onPressed: nextNames,
                                  child: const Text(
                                    'التالي',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed:
                    isRecording ? stopVideoRecording : startVideoRecording,
                child: Icon(isRecording ? Icons.stop : Icons.videocam),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
