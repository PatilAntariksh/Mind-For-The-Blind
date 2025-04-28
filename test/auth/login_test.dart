import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "fake-api-key",
        appId: "1:1234567890:web:abcdef123456",
        messagingSenderId: "1234567890",
        projectId: "test-project-id",
      ),
    );
  });

  testWidgets('Login page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.byType(TextField), findsNWidgets(2)); // Email + Password
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint), findsOneWidget);
  });
}
