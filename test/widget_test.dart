import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/main.dart';

void main() {
  testWidgets('App starts at IntroPage and navigates to WelcomePage', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(CapstoneProjectApp());

    // Verify the IntroPage is displayed
    expect(find.text("CAPSTONE PROJECT"), findsOneWidget);

    // Wait for the splash screen to transition (simulate the delay)
    await tester.pumpAndSettle(Duration(seconds: 4));

    // Verify that the WelcomePage appears after transition
    expect(find.text("CAPSTONE PROJECT"), findsWidgets);
  });

  testWidgets('Clicking "New User" navigates to SignUpPage', (WidgetTester tester) async {
    await tester.pumpWidget(CapstoneProjectApp());

    // Wait for navigation to WelcomePage
    await tester.pumpAndSettle(Duration(seconds: 4));

    // Find the "New User" button and tap it
    await tester.tap(find.text("New User"));
    await tester.pumpAndSettle();

    // Verify that SignUpPage appears
    expect(find.text("Sign Up"), findsOneWidget);
  });

  testWidgets('Clicking "Login" does not navigate without biometrics', (WidgetTester tester) async {
    await tester.pumpWidget(CapstoneProjectApp());

    // Wait for navigation to WelcomePage
    await tester.pumpAndSettle(Duration(seconds: 4));

    // Find and tap the "Login" button
    await tester.tap(find.text("Login"));
    await tester.pumpAndSettle();

    // Ensure we are still on the WelcomePage since biometrics should block navigation
    expect(find.text("CAPSTONE PROJECT"), findsWidgets);
  });
}
