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
