import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../../components/footer.dart';
import 'package:al_insan_app_front/pages/help.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
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
                    )
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
                          'Accueil',
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Présentation de l'organisation",
                      style: TextStyle(
                        color: const Color(0xFF4B935E),
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.29,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Association caritative algérienne dédiée à l'aide humanitaire et éducative, reflet des valeurs de solidarité du peuple.",
                      style: TextStyle(
                        color: const Color(0xFF1F2420),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Comment Aider',
                      style: TextStyle(
                        color: const Color(0xFF4B935E),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Responsive PageView with proper constraints
                    SizedBox(
                      height: 380, // Increased height to fit content
                      child: PageView(
                        controller: PageController(viewportFraction: 0.85),
                        children: [
                          _buildProjectCard(
                            'assets/mouton.jpg',
                            'Projet de sacrifices',
                            'Offrez un sacrifice pour nourrir les familles dans le besoin durant l\'Aïd',
                            isClickable: true,
                            context: context,
                          ),
                          _buildProjectCard(
                            'assets/vache.jpg',
                            'Projet de distribution de viande',
                            'Aidez à distribuer de la viande aux familles défavorisées.',
                            isClickable: false,
                          ),
                          _buildProjectCard(
                            'assets/chevre.jpg',
                            'Projet de chèvres',
                            'Soutenez l\'élevage de chèvres pour l\'autonomie alimentaire.',
                            isClickable: false,
                          ),
                          _buildProjectCard(
                            'assets/chameau.jpg',
                            'Projet de chameaux',
                            'Participez à l\'achat de chameaux pour soutenir les familles rurales.',
                            isClickable: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 39),
                    Text(
                      'Avis des utilisateurs',
                      style: TextStyle(
                        color: const Color(0xFF4B935E),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.85),
                        children: [
                          // Testimonial 1
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              width: 321,
                              padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
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
                                    color: Color(0x0C000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                    spreadRadius: -2,
                                  ),
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: -1,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 289,
                                          child: Text(
                                            '"Grâce à cette application, j’ai pu faire un don en quelques clics. Simple, rapide et transparent. Je recommande !"',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFF4A5565),
                                              fontSize: 14.31,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 1.68,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Karim .b',
                                            style: TextStyle(
                                              color: const Color(0xFF101828),
                                              fontSize: 14.31,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0.97,
                                            ),
                                          ),
                                          Text(
                                            'Donateur',
                                            style: TextStyle(
                                              color: const Color(0xFF4A5565),
                                              fontSize: 12.52,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0.97,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Testimonial 2
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              width: 321,
                              padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
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
                                    color: Color(0x0C000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                    spreadRadius: -2,
                                  ),
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: -1,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 289,
                                          child: Text(
                                            '"Interface intuitive et équipe très réactive. J’ai reçu un reçu immédiatement après mon don."',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFF4A5565),
                                              fontSize: 14.31,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 1.68,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nadia .k',
                                            style: TextStyle(
                                              color: const Color(0xFF101828),
                                              fontSize: 14.31,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0.97,
                                            ),
                                          ),
                                          Text(
                                            'Donatrice',
                                            style: TextStyle(
                                              color: const Color(0xFF4A5565),
                                              fontSize: 12.52,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0.97,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Testimonial 3
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              width: 321,
                              padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
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
                                    color: Color(0x0C000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                    spreadRadius: -2,
                                  ),
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 4),
                                    spreadRadius: -1,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 289,
                                          child: Text(
                                            '"Un grand merci à l’équipe pour leur sérieux et la transparence du processus de don."',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFF4A5565),
                                              fontSize: 14.31,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 1.68,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Yacine .z',
                                            style: TextStyle(
                                              color: const Color(0xFF101828),
                                              fontSize: 14.31,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0.97,
                                            ),
                                          ),
                                          Text(
                                            'Donateur',
                                            style: TextStyle(
                                              color: const Color(0xFF4A5565),
                                              fontSize: 12.52,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0.97,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(selectedIndex: 0),
    );
  }

  Widget _buildProjectCard(String imagePath, String title, String description, {required bool isClickable, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        width: 296.02,
        height: 380,
        child: Stack(
          children: [
            Container(
              width: 296.02,
              height: 380,
              padding: const EdgeInsets.all(24),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFFE5E7EB),
                  ),
                  borderRadius: BorderRadius.circular(9.25),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 145.51,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 259.64,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: 18.50,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.31,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9.09),
                  SizedBox(
                    width: 259.64,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: const Color(0xFF4A5565),
                        fontSize: 13.64,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: isClickable && context != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HelpPage()),
                            );
                          }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.13, vertical: 7.58),
                      decoration: ShapeDecoration(
                        color: isClickable ? const Color(0xFF4B935E) : Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.25),
                        ),
                        shadows: isClickable
                            ? [
                                BoxShadow(
                                  color: Color(0x051D293D),
                                  blurRadius: 0.50,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0.05,
                                )
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isClickable ? 'Contribuer' : 'Bientôt disponible',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(width: 4.55),
                          Icon(
                            isClickable ? Icons.arrow_forward : Icons.lock,
                            color: Colors.white,
                            size: 12.13,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isClickable)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9.25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9.25),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
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