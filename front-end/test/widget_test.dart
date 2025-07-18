// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:al_insan_app_front/pages/welcome.dart';

void main() {
  testWidgets('WelcomePage displays title and input fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomePage()));

    // Verify the title is present
    expect(find.text('Bienvenue'), findsOneWidget);

    // Verify the subtitle is present
    expect(find.text('Connectez-vous pour continuer à aider les autres'),
        findsOneWidget);

    // Verify the two WelcomeInput fields are present
    expect(find.text("Nom d'utilisateur"), findsOneWidget);
    expect(find.text("Mot de passe"), findsOneWidget);
  });
}
