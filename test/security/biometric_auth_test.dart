import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone_project/screens/login_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SharedPreferences.setMockInitialValues({
      'email': 'test@example.com',
      'password': '123456',
    });
  });

  testWidgets('Biometric login auto-fills credentials', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();

    final email = find.byType(TextField).first;
    final password = find.byType(TextField).last;

    expect((tester.widget(email) as TextField).controller?.text, 'test@example.com');
    expect((tester.widget(password) as TextField).controller?.text, '123456');
  });
}
