import 'package:flutter/material.dart';

class WorkerPageAfterLoggedIn extends StatefulWidget {
  const WorkerPageAfterLoggedIn({super.key});

  @override
  State<WorkerPageAfterLoggedIn> createState() =>
      _WorkerPageAfterLoggedInState();
}

class _WorkerPageAfterLoggedInState extends State<WorkerPageAfterLoggedIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEFB),
      body: Container(
        width: 414,
        height: 896,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFEFB), // Background
        ),
        child: Stack(
          children: [
            // Status Bar
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 414,
                height: 44,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFEFB), // Background
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 414,
                        height: 30,
                        child: const Stack(),
                      ),
                    ),
                    // Battery and signal indicators
                    Positioned(
                      left: 331,
                      top: 16,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 14,
                            child: const Stack(),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 16,
                            height: 14,
                            child: const Stack(),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 25,
                            height: 14,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 2,
                                  top: 3,
                                  child: Container(
                                    width: 19,
                                    height: 8,
                                    decoration: ShapeDecoration(
                                      color: const Color(
                                        0xFF1F2420,
                                      ), // text-color-main-body-text
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 337,
                      top: 8,
                      child: Container(
                        width: 6,
                        height: 6,
                        child: const Stack(),
                      ),
                    ),
                    Positioned(
                      left: 21,
                      top: 12,
                      child: Container(
                        width: 54,
                        height: 21,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 11,
                              top: 3,
                              child: Container(
                                width: 33,
                                height: 15,
                                child: const Stack(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Header
            Positioned(
              left: 0,
              top: 44,
              child: Container(
                width: 414,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFEFB),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3FE4E4E7),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 294,
                      child: Text(
                        'Accueil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF09090B), // Zinc-950
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.20,
                          letterSpacing: -0.20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Camera Button
            Positioned(
              left: 127,
              top: 255,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(111.55),
                  onTap: () {
                    print(
                      '🎬 Camera button tapped - Navigating to camera page',
                    );
                    // Navigate to camera page
                    Navigator.pushNamed(context, '/camera');
                  },
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [
                          Color(0xFF93C29C), // main-shades-main-300
                          Color(0xFF4B935E), // Main
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(111.55),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3362B655),
                          blurRadius: 52.54,
                          offset: Offset(0, 26.27),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Instruction Text
            Positioned(
              left: 52,
              top: 456,
              child: SizedBox(
                width: 311,
                child: Text(
                  'Cliquez pour ouvrir la caméra et commencer l\'enregistrement.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.33,
                    letterSpacing: -0.18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
