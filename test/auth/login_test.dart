import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/login_page.dart';
import '../firebase_setup.dart';

void main() {
  setUpAll(() async {
    await initializeFirebase();
  });

  testWidgets('Login page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint), findsOneWidget);
  });
}
