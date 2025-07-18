// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:al_insan_app_front/main.dart';

void main() {
  testWidgets('Camera button is present and navigates to CameraPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify the button is present
    expect(find.text('Open Selfie Camera'), findsOneWidget);

    // Tap the button and trigger navigation
    await tester.tap(find.text('Open Selfie Camera'));
    await tester.pumpAndSettle();

    // After navigation, CameraPage should be present (AppBar title check)
    expect(find.text('Selfie Camera'), findsOneWidget);
  });
}
