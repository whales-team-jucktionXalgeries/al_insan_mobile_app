import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevConnect',
      
      // Localization support
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', ''), // French
        Locale('ar', ''), // Arabic
      ],
      locale: const Locale('fr', ''), // Default to French
      
      home: const ChatsPage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}