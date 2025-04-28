import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "fake-api-key",
        appId: "1:1234567890:web:abcdef123456",
        messagingSenderId: "1234567890",
        projectId: "test-project-id",
      ),
    );
  });

  testWidgets('Biometric login pre-fills stored credentials', (WidgetTester tester) async {
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
