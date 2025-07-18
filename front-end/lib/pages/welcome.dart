import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../components/welcome_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            const SizedBox(height: 30),

            // Title
            const Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // Subtitle
            const Text(
              'Connectez-vous pour continuer à aider les autres',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Confirm Button
            WelcomeInput(
                text: "Nom d’utilisateur",
                icon: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 23,
                height: 23,
                fit: BoxFit.scaleDown,

              ),
              ),
              const SizedBox(height: 20),
              WelcomeInput(
                text: "Mot de passe",
                icon: SvgPicture.asset(
                'assets/icons/eye.svg',
                width: 23,
                height: 23,
                fit: BoxFit.scaleDown,

              ),
                
              ),
              const SizedBox(height: 16),
              
              
          ],
        ),
      ),
    );
  }
}