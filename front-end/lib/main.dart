import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import '../../components/footer.dart';
import 'pages/sign_up_page.dart';
import 'pages/chats.dart';
import 'pages/chats_full.dart';
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
      home: const ChatsFull(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}