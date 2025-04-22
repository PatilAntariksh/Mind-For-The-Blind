import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/intro_page.dart';
import 'screens/welcome_page.dart';
import 'screens/signup_page.dart';
import 'screens/login_page.dart';
import 'screens/mode_selection.dart';
import 'screens/camera_screen.dart';
import 'screens/test_inference_screen.dart';
import 'screens/ai_assistant.dart';
import 'screens/video_room.dart';
import 'screens/video_call.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(CapstoneProjectApp());
}

class CapstoneProjectApp extends StatelessWidget {
  const CapstoneProjectApp({super.key});

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
        '/camera': (context) => CameraScreen(), // Added CameraScreen route
        '/test_inference': (context) => const TestInferenceScreen(),
        '/ai_assistant' : (context) => const AIAssistantScreen(),
        '/video_room': (context) => VideoRoomPage(),
        '/video_call': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return VideoCallPage(roomId: args['roomId']);
        },

      },
    );
  }
}