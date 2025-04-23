import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone_project/screens/signup_page.dart';

void main() {
  // Required to initialize Firebase before test
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('SignUpPage renders correctly with all fields and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpPage(),
      ),
    );

    // Check for two input fields and a Sign Up button
    expect(find.byType(TextField), findsNWidgets(2)); // Email + Password
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
