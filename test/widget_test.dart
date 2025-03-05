import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_for_the_blind/main.dart';  
import 'package:mind_for_the_blind/screens/intro_page.dart';
import 'package:mind_for_the_blind/screens/welcome_page.dart';
import 'package:mind_for_the_blind/screens/signup_page.dart';
import 'package:mind_for_the_blind/screens/login_page.dart';
import 'package:mind_for_the_blind/screens/mode_selection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(); 
  });

  testWidgets('App starts at IntroPage and navigates to WelcomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IntroPage()));

   
    expect(find.text('Mind For the Blind'), findsOneWidget);

    
    await tester.pump(Duration(seconds: 5));


    await tester.pumpAndSettle();
    expect(find.byType(WelcomePage), findsOneWidget);
  });

  testWidgets('Clicking "New User" navigates to SignUpPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WelcomePage()));

  
    expect(find.text('New User'), findsOneWidget);

   
    await tester.tap(find.text('New User'));
    await tester.pumpAndSettle();

   
    expect(find.byType(SignUpPage), findsOneWidget);
  });

  testWidgets('Clicking "Login" navigates to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WelcomePage()));

   
    expect(find.text('Login'), findsOneWidget);

    
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

 
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('Signup form has required fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignUpPage()));

    
    expect(find.byType(TextField), findsNWidgets(4)); 

    
    expect(find.text('Blind'), findsOneWidget);
    expect(find.text('Helper'), findsNothing);
  });

  testWidgets('ModeSelection page shows "Coming Soon"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ModeSelection()));

   
    expect(find.text('Coming Soon...'), findsOneWidget);
  });
}
