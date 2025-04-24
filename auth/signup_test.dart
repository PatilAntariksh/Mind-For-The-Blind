import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone_project/screens/signup_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Signup screen has input fields and Sign Up button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

    expect(find.byType(TextField), findsNWidgets(4)); // Name, Email, Password, Confirm
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
