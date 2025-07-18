import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import '../../components/footer.dart';

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
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Your scrollable content here
            ],
          ),
        ),
        bottomNavigationBar: CustomFooter(),
      ),
    );
  }
}