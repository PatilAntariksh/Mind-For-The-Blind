import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_for_the_blind/main.dart';
import 'package:mind_for_the_blind/screens/intro_page.dart';
import 'package:mind_for_the_blind/screens/welcome_page.dart';
import 'package:mind_for_the_blind/screens/signup_page.dart';
import 'package:mind_for_the_blind/screens/login_page.dart';
import 'package:mind_for_the_blind/screens/Mode_selection.dart';


class MockFirebaseApp extends Firebase {
  static Future<void> initialize() async {}
}

void main() {
  setUpAll(() async {
    await MockFirebaseApp.initialize();
  });

  testWidgets('App starts at IntroPage and navigates to WelcomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MindForTheBlindApp());

 
    expect(find.text('Mind For the Blind'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    
    await tester.pumpAndSettle(Duration(seconds: 5));

   
    expect(find.text('Mind For the Blind'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('New User'), findsOneWidget);
  });

  testWidgets('Clicking "New User" navigates to SignUpPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: WelcomePage(),
      routes: {'/signup': (context) => SignUpPage()},
    ));

   
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('New User'), findsOneWidget);

 
    await tester.tap(find.text('New User'));
    await tester.pumpAndSettle();

  
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('Clicking "Login" navigates to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: WelcomePage(),
      routes: {'/login': (context) => LoginPage()},
    ));

 
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('New User'), findsOneWidget);

    
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Clicking "Sign Up" registers user and shows success message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SignUpPage(),
    ));

    await tester.enterText(find.byType(TextField).at(0), 'John');
    await tester.enterText(find.byType(TextField).at(1), 'Doe');
    await tester.enterText(find.byType(TextField).at(2), 'johndoe@example.com');
    await tester.enterText(find.byType(TextField).at(3), 'password123');
    await tester.tap(find.text('Sign Up'));
    await tester.pump();


    expect(find.text('User Registered Successfully! Redirecting...'), findsOneWidget);
  });

  testWidgets('Clicking "Login" does not navigate without biometrics', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

  
    await tester.enterText(find.byType(TextField).at(0), 'johndoe@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    await tester.tap(find.text('Login'));
    await tester.pump();


    expect(find.textContaining("Login Successful"), findsOneWidget);
  });

  testWidgets('Mode Selection screen displays "Coming Soon..."', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ModeSelection(),
    ));

    expect(find.text('Coming Soon...'), findsOneWidget);
    expect(find.text('Coming Soon'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
