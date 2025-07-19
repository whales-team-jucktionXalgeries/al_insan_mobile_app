import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header (Conversation container) - same styling as Messagerie
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF09090B),
                      size: 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  // Title
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        'Conversation',
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
                  // Empty space to balance the back button
                  SizedBox(width: 48),
                ],
              ),
            ),
            // Body content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(), // Push messages to bottom
                    AdminMessage(
                      text: 'votre donation a ete confirme',
                    ),
                    const SizedBox(height: 12),
                    AdminMessage(
                      text: "vous allez recevoir la video du sacrifice dés qu'on la prend",
                    ),
                    // No input field, user cannot send anything
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminMessage extends StatelessWidget {
  final String text;
  const AdminMessage({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFBEDCC2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
} 