import 'package:flutter/material.dart';
import 'package:al_insan_app_front/theme/colors.dart'; // if you're using AppColors

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // you can provide callback or leave it null
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: ShapeDecoration(
          color: AppColors.primary, // or Color(0xFF4B935E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.surface,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}