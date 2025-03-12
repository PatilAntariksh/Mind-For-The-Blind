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

  runApp(CapstoneProjectApp()); // Removed 'const'
}

class CapstoneProjectApp extends StatelessWidget {
  CapstoneProjectApp({Key? key}) : super(key: key); // Removed 'const'

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mind for the Blind",
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(), // Removed 'const'
        '/welcome': (context) => WelcomePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/mode_selection': (context) => ModeSelection(),
      },
    );
  }
}
