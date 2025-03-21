import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/intro_page.dart';
import 'screens/welcome_page.dart';
import 'screens/signup_page.dart';
import 'screens/login_page.dart';
import 'screens/mode_selection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(CapstoneProjectApp());
}

class CapstoneProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mind for the Blind",
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/welcome': (context) => WelcomePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/mode_selection': (context) => ModeSelection(),
        // Add mode selection or any other screens here
      },
    );
  }
}
