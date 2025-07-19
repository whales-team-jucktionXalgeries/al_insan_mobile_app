import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../components/welcome_input.dart';
import '../../components/big_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  const SizedBox(height: 85),
            
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
                      color: AppColors.text,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
            
                  // Confirm Button
                  WelcomeInput(
                      hintText: "Nom d’utilisateur",
                      
                    isAlphabetOnly: true,
                    ),
                    const SizedBox(height: 20),
                    WelcomeInput(
                      hintText: "Mot de passe",
                    isPassword: true,
                      
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
            width: 16,
            height: 16,
            decoration: ShapeDecoration(
              color: const Color(0xFFF9FAFB),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: AppColors.border,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
                ),
                const SizedBox(width: 10),
                const Text(
            'Se souvenir de moi',
            style: TextStyle(
              color: Color(0xFF101828),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
                ),
              ],
              
            ),
            const SizedBox(height: 46),
            Container(
              width: 374,
              height: 0.1,
              color: Color.fromRGBO(15, 31, 21, 1), // or any subtle color
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: 374,
                child: Text.rich(
              TextSpan(
                  children: [
                      TextSpan(
                          text: 'Vous n’avez pas de compte ? ',
                          style: TextStyle(
                              color: const Color(0xFF1F2420) /* text-color-main-body-text */,
                              fontSize: 16,
                              fontFamily: 'Baloo Bhaijaan 2',
                              fontWeight: FontWeight.w400,
                              height: 1.87,
                          ),
                      ),
                      TextSpan(
                          text: 'Créez-en un',
                          style: TextStyle(
                              color: const Color(0xFF1F2420) /* text-color-main-body-text */,
                              fontSize: 16,
                              fontFamily: 'Baloo Bhaijaan 2',
                              fontWeight: FontWeight.w600,
                              height: 1.87,
                          ),
                      ),
                  ],
              ),
              textAlign: TextAlign.center,
                ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'S’inscrire',
              onPressed: () {
                // TODO: Add your login logic
                print('Connexion button pressed');
              },
            ),
            
                    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}