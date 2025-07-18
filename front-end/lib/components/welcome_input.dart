import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeInput extends StatefulWidget {
  final String hintText;
  final bool isAlphabetOnly;
  final bool isPassword;

  const WelcomeInput({
    Key? key,
    required this.hintText,
    this.isAlphabetOnly = false,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<WelcomeInput> createState() => _WelcomeInputState();
}

class _WelcomeInputState extends State<WelcomeInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF3F4F6),
      ),
      child: Row(
        children: [
          // Input field
          Expanded(
            child: TextField(
              obscureText: widget.isPassword ? _obscureText : false,
              inputFormatters: widget.isAlphabetOnly
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))]
                  : [],
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),

          // If password, show eye icon
          if (widget.isPassword)
            GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SvgPicture.asset(
                  _obscureText
                      ? 'assets/icons/eye-slash.svg'
                      : 'assets/icons/eye.svg',
                  width: 23,
                  height: 23,
                ),
              ),
            ),

          // If not password, show user icon on the right
          if (!widget.isPassword)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 23,
                height: 23,
              ),
            ),
        ],
      ),
    );
  }
}