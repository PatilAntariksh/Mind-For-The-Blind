import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Login page renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.byType(TextField), findsNWidgets(2)); // Email + Password
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint), findsOneWidget); // Biometrics button
  });
}
