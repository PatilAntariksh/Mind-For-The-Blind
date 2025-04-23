import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/signup_page.dart';

void main() {
  testWidgets('SignUpPage renders correctly with all fields and button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

    // Check for the presence of email and password fields and sign up button
    expect(find.byType(TextField), findsNWidgets(2)); // email + password
    expect(find.text('Sign Up'), findsOneWidget);     // button label
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
