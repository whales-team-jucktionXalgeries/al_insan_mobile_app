import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:al_insan_app_front/camera_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevConnect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CameraPage(cameras: cameras),
    );
  }
}