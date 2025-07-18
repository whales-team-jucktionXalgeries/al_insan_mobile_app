import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import '../../components/footer.dart';
import 'pages/sign_up_page.dart';
import 'pages/chats.dart';
import 'pages/chats_full.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevConnect',
      home: const ChatsFull(),
    );
  }
}