import 'package:al_insan_app_front/components/welcome_input.dart';
import 'package:al_insan_app_front/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'pages/chats.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevConnect',
      home: const WelcomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}