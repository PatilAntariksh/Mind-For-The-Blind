import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Biometric login auto-fills stored credentials', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'email': 'test@example.com',
      'password': 'password123',
    });

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();

    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    expect((tester.widget(emailField) as TextField).controller?.text, equals('test@example.com'));
    expect((tester.widget(passwordField) as TextField).controller?.text, equals('password123'));
  });
}
