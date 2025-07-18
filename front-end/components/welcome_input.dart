import 'package:flutter/material.dart';

class WelcomeInput extends StatelessWidget {
  final String text;
  final IconData icon;

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
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x051D293D),
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
                color: Color(0xFF919592),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ),
          SizedBox(
            width: 23,
            height: 23,
            child: Icon(
              icon,
              size: 23,
              color: Colors.black, // or any color you prefer
            ),
          ),
        ],
      ),
    );
  }
}