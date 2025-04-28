import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets('Signup page renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

    expect(find.byType(TextField), findsNWidgets(4)); // First name, last name, email, password
    expect(find.text('Sign Up'), findsOneWidget); 
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
