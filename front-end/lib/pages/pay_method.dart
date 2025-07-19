import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/colors.dart';
import '../components/footer.dart';

class PayMethodPage extends StatefulWidget {
  const PayMethodPage({Key? key}) : super(key: key);

  @override
  State<PayMethodPage> createState() => _PayMethodPageState();
}

class _PayMethodPageState extends State<PayMethodPage> {
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
            // Chevron left icon
            Padding(
              padding: const EdgeInsets.only(top: 19, left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    Icons.chevron_left,
                    color: Color(0xFF09090B),
                    size: 31,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 23),
            SizedBox(
              width: 290,
              child: Text(
                'Sélectionnez votre méthode de paiement préférée.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.87,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: 381,
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Edahabia Card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/edahabia.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            Color(0xFF6B7280),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    width: 381,
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PayPal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/paypal.svg',
                          width: 18,
                          height: 18,
                          
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    width: 381,
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Carte Bancaire',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/carte_bancaire.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            Color(0xFF6B7280),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    width: 381,
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PayPal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/paypal.svg',
                          width: 18,
                          height: 18,
                        
                        ),
                      ],
                    ),
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
