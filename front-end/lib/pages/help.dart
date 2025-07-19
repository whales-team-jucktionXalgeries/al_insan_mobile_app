import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../components/footer.dart';
import '../camera_page.dart';
import 'mouton.dart';
import 'chevre.dart';
import 'vache.dart';
import 'chameau.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with white background (Aide container)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: SizedBox(
                      width: 294,
                      child: Text(
                        'Aider',
                        textAlign: TextAlign.center,
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x051D293D),
                          blurRadius: 0.50,
                          offset: Offset(0, 1),
                          spreadRadius: 0.05,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Icon(
                            Icons.search,
                            size: 16,
                            color: const Color(0xFF6A7282),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: const Color(0xFF6A7282),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                            style: TextStyle(
                              color: const Color(0xFF09090B),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Choisir l\'animal',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Animal selection grid
                  Column(
                    children: [
                      // First row - 2 containers side by side
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigate to Mouton page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MoutonPage(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10.18),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.all(8.48),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.85,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: BorderRadius.circular(10.18),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 3.39,
                                      offset: Offset(0, 1.70),
                                      spreadRadius: -1.70,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 5.09,
                                      offset: Offset(0, 3.39),
                                      spreadRadius: -0.85,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 160,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/mouton.jpg",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4.24),
                                    SizedBox(
                                      width: 143.04,
                                      child: Text(
                                        'Mouton',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF0F1F15),
                                          fontSize: 16.96,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 1.60,
                                          letterSpacing: -0.34,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigate to Chèvre page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChevrePage(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10.18),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.all(8.48),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.85,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: BorderRadius.circular(10.18),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 3.39,
                                      offset: Offset(0, 1.70),
                                      spreadRadius: -1.70,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 5.09,
                                      offset: Offset(0, 3.39),
                                      spreadRadius: -0.85,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 160,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/chevre.jpg",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4.24),
                                    SizedBox(
                                      width: 143.04,
                                      child: Text(
                                        'Chèvre',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF0F1F15),
                                          fontSize: 16.96,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 1.60,
                                          letterSpacing: -0.34,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Second row - 2 containers side by side
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigate to Vache page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const VachePage(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10.18),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.all(8.48),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.85,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: BorderRadius.circular(10.18),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 3.39,
                                      offset: Offset(0, 1.70),
                                      spreadRadius: -1.70,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 5.09,
                                      offset: Offset(0, 3.39),
                                      spreadRadius: -0.85,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 160,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/vache.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4.24),
                                    SizedBox(
                                      width: 143.04,
                                      child: Text(
                                        'Vache',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF0F1F15),
                                          fontSize: 16.96,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 1.60,
                                          letterSpacing: -0.34,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigate to Chameau page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChamPage(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10.18),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.all(8.48),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.85,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    borderRadius: BorderRadius.circular(10.18),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0C000000),
                                      blurRadius: 3.39,
                                      offset: Offset(0, 1.70),
                                      spreadRadius: -1.70,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 5.09,
                                      offset: Offset(0, 3.39),
                                      spreadRadius: -0.85,
                                    ),
                                    BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 160,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/chameau.jpg",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4.24),
                                    SizedBox(
                                      width: 143.04,
                                      child: Text(
                                        'Chameau',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF0F1F15),
                                          fontSize: 16.96,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 1.60,
                                          letterSpacing: -0.34,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // No content in the center
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
      bottomNavigationBar: CustomFooter(selectedIndex: 1),
    );
  }
}
