import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mock Firebase dependencies
@GenerateMocks([FirebaseApp, Firebase])
void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Register a default instance to mock Firebase behavior
  FirebasePlatform.instance = MockFirebasePlatform();
}

Future<void> initializeMockFirebase() async {
  setupFirebaseMocks();
  await Firebase.initializeApp();
}

// Mock implementation for Firebase Core
class MockFirebasePlatform extends FirebasePlatform {
  @override
  Future<FirebaseApp> initializeApp({String? name, FirebaseOptions? options}) async {
    return MockFirebaseApp();
  }
}

// Mock Firebase App
class MockFirebaseApp extends Mock implements FirebaseApp {}
