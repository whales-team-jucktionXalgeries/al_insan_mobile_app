import 'package:al_insan_app_front/theme/colors.dart';
import 'package:flutter/material.dart';

class WelcomeInput extends StatelessWidget {
  final String text;
  final Widget icon;

  const WelcomeInput({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: ShapeDecoration(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 0.5,
            offset: Offset(0, 1),
            spreadRadius: 0.05,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.placeholder,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ),
          SizedBox(
            width: 23,
            height: 23,
            child: icon,
          ),
        ],
      ),
    );
  }
}