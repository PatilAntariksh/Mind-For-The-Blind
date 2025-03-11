import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/main.dart';
import 'package:capstone_project/screens/intro_page.dart';
import 'package:capstone_project/screens/welcome_page.dart';
import 'package:capstone_project/screens/signup_page.dart';
import 'package:capstone_project/screens/login_page.dart';
import 'package:capstone_project/screens/mode_selection.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('App starts at IntroPage and navigates to WelcomePage', (WidgetTester tester) async {
      await tester.pumpWidget(CapstoneProjectApp());
      expect(find.byType(IntroPage), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(WelcomePage), findsOneWidget);
    });

    testWidgets('Clicking "New User" navigates to SignUpPage', (WidgetTester tester) async {
      await tester.pumpWidget(CapstoneProjectApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text("New User"));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpPage), findsOneWidget);
    });

    testWidgets('Clicking "Login" navigates to LoginPage', (WidgetTester tester) async {
      await tester.pumpWidget(CapstoneProjectApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text("Login"));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}