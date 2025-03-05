import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_for_the_blind/screens/intro_page.dart';
import 'package:mind_for_the_blind/screens/welcome_page.dart';
import 'package:mind_for_the_blind/screens/signup_page.dart';
import 'package:mind_for_the_blind/screens/login_page.dart';
import 'package:mind_for_the_blind/screens/Mode_selection.dart';

void main() {
  testWidgets('App starts at IntroPage and navigates to WelcomePage', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => IntroPage(),
          '/welcome': (context) => WelcomePage(),
        },
      ),
    );

    await tester.pump(Duration(seconds: 5)); // Simulate the 5-second delay in IntroPage

    expect(find.byType(WelcomePage), findsOneWidget);
  });

  testWidgets('Clicking "New User" navigates to SignUpPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/welcome',
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/signup': (context) => SignUpPage(),
        },
      ),
    );

    await tester.tap(find.text('New User')); // Simulate clicking the "New User" button
    await tester.pumpAndSettle(); // Wait for animation to complete

    expect(find.byType(SignUpPage), findsOneWidget);
  });

  testWidgets('Clicking "Login" navigates to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/welcome',
        routes: {
          '/welcome': (context) => WelcomePage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );

    await tester.tap(find.text('Login')); // Simulate clicking the "Login" button
    await tester.pumpAndSettle(); // Wait for animation to complete

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('ModeSelection page shows "Coming Soon"', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ModeSelection(),
      ),
    );

    expect(find.text('Coming Soon...'), findsOneWidget);
  });
}
