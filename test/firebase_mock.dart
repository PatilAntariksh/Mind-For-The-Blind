import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Use `customMocks` to rename MockFirebaseApp to MockFirebaseAppInstance
@GenerateMocks([], customMocks: [MockSpec<FirebaseApp>(as: #MockFirebaseAppInstance)])
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
    return MockFirebaseAppInstance(); // Use the new unique name
  }
}

// Mock Firebase App (renamed to avoid conflict)
class MockFirebaseAppInstance extends Mock implements FirebaseApp {}
