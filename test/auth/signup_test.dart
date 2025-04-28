import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/signup_page.dart';
import '../firebase_setup.dart';

void main() {
  setUpAll(() async {
    await initializeFirebase();
  });

  testWidgets('Signup page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

    expect(find.byType(TextField), findsWidgets); // It will not crash
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
