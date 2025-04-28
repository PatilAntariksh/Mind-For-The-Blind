import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/login_page.dart';
import '../mocks/mock_services.dart';

void main() {
  testWidgets('Login page UI renders properly', (tester) async {
    final mockAuth = MockFirebaseAuth();
    final mockTts = MockFlutterTts();

    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.fingerprint), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
