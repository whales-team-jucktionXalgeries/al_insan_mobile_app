import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';

class RegisterInput extends StatelessWidget {
  final String text;

  const RegisterInput({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.placeholder, 
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 1.43,
        ),
      ),
    );
  }
}