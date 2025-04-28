import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/signup_page.dart';
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

  testWidgets('Signup page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));

    expect(find.byType(TextField), findsNWidgets(4)); // 4 fields
    expect(find.byType(ElevatedButton), findsWidgets); // buttons
  });
}
