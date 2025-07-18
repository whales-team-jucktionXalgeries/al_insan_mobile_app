import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:al_insan_app_front/services/video_queue.dart';
import 'package:al_insan_app_front/services/video_sync_service.dart';
import 'package:shake/shake.dart';
import 'package:torch_light/torch_light.dart';
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
    int end = (nameIndex + namesPerPage < names.length)
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
    setState(() {});
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
      // Blink flash once, wait 1s, then start recording
      await _blinkFlash(times: 1);
      await Future.delayed(const Duration(seconds: 1));
      await controller!.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } else {
      // Stop recording, then blink flash twice
      await controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      await controller!.dispose();
      await Future.delayed(const Duration(milliseconds: 500));
      await _blinkFlash(times: 2);
      await _initCamera();
    }
  }

  Future<void> _blinkFlash({int times = 1}) async {
    // This will blink the physical back camera's flash, even if the front camera is active
    for (int i = 0; i < times; i++) {
      try {
        await TorchLight.enableTorch();
        await Future.delayed(const Duration(milliseconds: 300));
        await TorchLight.disableTorch();
        if (i < times - 1) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
      } catch (e) {
        // Flash not available or error
      }
    }
  }

  Future<void> startVideoRecording() async {
    if (controller == null || controller!.value.isRecordingVideo) return;
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String filePath =
        '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    await controller!.startVideoRecording();
    setState(() {
      isRecording = true;
      videoPath = filePath;
      resetNames();
    });
  }

  Future<void> stopVideoRecording() async {
    if (controller == null || !controller!.value.isRecordingVideo) return;
    final XFile file = await controller!.stopVideoRecording();
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String filePath =
        '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    print('Saving video to: $filePath');
    await file.saveTo(filePath);
    print('Saved to app dir, now saving to gallery...');
    await GallerySaver.saveVideo(filePath);
    print('Saved to gallery!');
    
    setState(() {
      isRecording = false;
      videoPath = filePath;
    });

    // 🧠 Your Supabase user ID (you'll need to pass it here)
    final userId = "USER_ID_HERE"; // Replace with actual user ID logic

    // ✅ Add to queue and trigger sync
    await VideoQueue.addToQueue(filePath, userId);
    await VideoSyncService.syncQueuedVideos();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Video saved and queued for upload!')),
    );
  }

  @override
  void dispose() {
    shakeDetector?.stopListening();
    _shakeTimer?.cancel();
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
          if (isRecording)
            Container(
              color: Colors.white.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...currentNames.map((name) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
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
                              )),
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
                                  child: const Text('التالي',
                                      style: TextStyle(fontSize: 20)),
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
