import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:al_insan_app_front/services/session.dart';
import 'package:al_insan_app_front/services/video_sync_service.dart';

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
  String sessionId = "";
  Directory sessionDir = Directory("");

  List<String> get currentNames {
    final end = (nameIndex + namesPerPage < names.length)
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
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    controller = CameraController(frontCamera, ResolutionPreset.high);
    controller!.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  Future<void> startVideoRecording() async {
    try {
      sessionId = DateTime.now().millisecondsSinceEpoch.toString();
      sessionDir = await DonationSessionManager.createSession(sessionId);

      if (controller == null || controller!.value.isRecordingVideo) return;

      final String filePath = '${sessionDir.path}/$sessionId.mp4';
      await controller!.startVideoRecording();

      setState(() {
        isRecording = true;
        videoPath = filePath;
        resetNames();
      });
    } catch (e) {
      _showError('Failed to start recording: $e');
    }
  }

  Future<void> stopVideoRecording() async {
    try {
      if (controller == null || !controller!.value.isRecordingVideo) return;

      final XFile file = await controller!.stopVideoRecording();
      final String filePath = '${sessionDir.path}/$sessionId.mp4';
      await file.saveTo(filePath);
      await GallerySaver.saveVideo(filePath);

      final File jsonFile = File('${sessionDir.path}/names.json');
      await jsonFile.writeAsString(jsonEncode(names));

      final File videoFile = File(filePath);

      setState(() {
        isRecording = false;
        videoPath = filePath;
      });

      await DonationSessionManager.saveSession(
        sessionId,
        videoFile,
        jsonFile,
      );

      // 🔁 Try to sync if online
      await VideoSyncService.syncAllSessionsIfOnline();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video saved and queued for upload!')),
      );
    } catch (e) {
      _showError('Failed to stop recording: $e');
    }
  }


  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Selfie Camera')),
      body: Stack(
        children: [
          CameraPreview(controller!),
          if (isRecording)
            Container(
              color: Colors.white.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...currentNames.map(
                            (name) => Padding(
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
                                  child: const Text('التالي',
                                      style: TextStyle(fontSize: 20)),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: isRecording
                    ? stopVideoRecording
                    : startVideoRecording,
                child: Icon(isRecording ? Icons.stop : Icons.videocam),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
