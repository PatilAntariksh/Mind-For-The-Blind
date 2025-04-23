import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:local_auth/local_auth.dart';

// Create a mock class
class MockLocalAuth extends Mock implements LocalAuthentication {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Biometric login auto-fills stored credentials', (WidgetTester tester) async {
    // Set mock preferences
    SharedPreferences.setMockInitialValues({
      'email': 'test@example.com',
      'password': 'password123',
    });

    // Build the LoginPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    // Wait for any async operations
    await tester.pumpAndSettle();

    // Verify email and password are pre-filled from SharedPreferences
    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    expect(
      (tester.widget(emailField) as TextField).controller?.text,
      equals('test@example.com'),
    );
    expect(
      (tester.widget(passwordField) as TextField).controller?.text,
      equals('password123'),
    );
  });
}
