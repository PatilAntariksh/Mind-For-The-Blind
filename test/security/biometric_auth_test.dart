import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone_project/screens/login_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({
      'email': 'test@example.com',
      'password': 'password123',
    });
  });

  testWidgets('Biometric login pre-fills stored credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();

    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    final emailText = (tester.widget(emailField) as TextField).controller?.text;
    final passwordText = (tester.widget(passwordField) as TextField).controller?.text;

    expect(emailText, 'test@example.com');
    expect(passwordText, 'password123');
  });
}
