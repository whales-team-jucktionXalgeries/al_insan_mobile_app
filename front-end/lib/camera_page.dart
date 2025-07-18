import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

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

  @override
  void initState() {
    super.initState();
    // Find the front camera
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
    if (controller == null || controller!.value.isRecordingVideo) return;
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String filePath =
        '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    await controller!.startVideoRecording();
    setState(() {
      isRecording = true;
      videoPath = filePath;
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Video saved to $filePath')),
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
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text('Selfie Camera')),
      body: Stack(
        children: [
          CameraPreview(controller!),
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
