import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_for_the_blind/main.dart';
import 'package:mind_for_the_blind/screens/intro_page.dart';
import 'package:mind_for_the_blind/screens/welcome_page.dart';
import 'package:mind_for_the_blind/screens/signup_page.dart';
import 'package:mind_for_the_blind/screens/login_page.dart';
import 'package:mind_for_the_blind/screens/mode_selection.dart';
import 'firebase_mock.dart';
import 'firebase_auth_mock.dart';

void main() {
  late FirebaseAuth mockAuth;
  late FirebaseFirestore mockDb;

  setUpAll(() async {
    await initializeMockFirebase();
    mockAuth = mockFirebaseAuth(); 
    mockDb = mockFirestore(); 
  });

  testWidgets("App starts at IntroPage and navigates to WelcomePage", (WidgetTester tester) async {
    await tester.pumpWidget(MindForTheBlindApp());

    // Verify that the IntroPage is shown initially
    expect(find.byType(IntroPage), findsOneWidget);

    // Navigate
    await tester.pumpAndSettle();

    // Verify that WelcomePage appears
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

    await tester.tap(find.text("New User"));
    await tester.pumpAndSettle();

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

    await tester.tap(find.text("Login"));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets("ModeSelection page shows 'Coming Soon'", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ModeSelection(),
    ));

    expect(find.text("Coming Soon..."), findsOneWidget);
  });
}
