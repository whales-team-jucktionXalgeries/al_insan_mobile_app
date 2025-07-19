import 'package:flutter/material.dart';
import 'package:al_insan_app_front/components/profile_settings.dart';
import 'package:al_insan_app_front/components/footer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEFB),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF09090B),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.20,
            letterSpacing: -0.20,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile picture
                    Container(
                      width: 94.98,
                      height: 94.98,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/Avatar.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Anna Smith name
                    const Text(
                      'Anna smith',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1F2420),
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.87,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Profile settings component
                    const ProfileSettings(),
                  ],
                ),
              ),
            ),
            // Footer at the bottom
            const CustomFooter(selectedIndex: 3),
          ],
        ),
      ),
    );
  }
}
