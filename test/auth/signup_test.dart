import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/signup_page.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // We won't call Firebase.initializeApp() in the real app
    // We'll use MockFirebaseAuth to mock everything
  });

  testWidgets('Signup page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpPage(),
      ),
    );

    // Adjust according to your SignUpPage text fields and button
    expect(find.byType(TextField), findsNWidgets(4)); // First Name, Last Name, Email, Password
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
