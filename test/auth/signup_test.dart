import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/signup_page.dart';

void main() {
  testWidgets('Signup page UI renders properly', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

    expect(find.byType(TextField), findsNWidgets(4));
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
