import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_for_the_blind/screens/intro_page.dart';
import 'package:mind_for_the_blind/screens/welcome_page.dart';
import 'package:mind_for_the_blind/screens/signup_page.dart';
import 'package:mind_for_the_blind/screens/login_page.dart';
import 'package:mind_for_the_blind/screens/Mode_selection.dart';
import 'firebase_mock.dart'; 

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Ensures Firebase initializes before tests
  });

  testWidgets("App starts at IntroPage and navigates to WelcomePage", (WidgetTester tester) async {
    await tester.pumpWidget(MindForTheBlindApp());

    // Verify that the IntroPage is shown initially
    expect(find.byType(IntroPage), findsOneWidget);

    // Wait for navigation to WelcomePage (simulate 5-second delay)
    await tester.pumpAndSettle(Duration(seconds: 6));

    // Verify that WelcomePage appears after IntroPage
    expect(find.byType(WelcomePage), findsOneWidget);
  });

  testWidgets("Clicking 'New User' navigates to SignUpPage", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/signup': (context) => SignUpPage(),
      },
    ));

    // Find the 'New User' button and tap it
    await tester.tap(find.text("New User"));
    await tester.pumpAndSettle();

    // Verify we navigated to SignUpPage
    expect(find.byType(SignUpPage), findsOneWidget);
  });

  testWidgets("Clicking 'Login' navigates to LoginPage", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
      },
    ));

    // Find the 'Login' button and tap it
    await tester.tap(find.text("Login"));
    await tester.pumpAndSettle();

    // Verify we navigated to LoginPage
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets("ModeSelection page shows 'Coming Soon'", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ModeSelection(),
    ));

    // Verify "Coming Soon" text is present
    expect(find.text("Coming Soon..."), findsOneWidget);
  });
}
