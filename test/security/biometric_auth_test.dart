import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SharedPreferences.setMockInitialValues({
      'email': 'test@example.com',
      'password': 'password123',
    });
  });

  testWidgets('Biometric login auto-fills stored credentials', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    await tester.pumpAndSettle();

    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    final emailWidget = tester.widget<TextField>(emailField);
    final passwordWidget = tester.widget<TextField>(passwordField);

    expect(emailWidget.controller?.text, equals('test@example.com'));
    expect(passwordWidget.controller?.text, equals('password123'));
  });
}
