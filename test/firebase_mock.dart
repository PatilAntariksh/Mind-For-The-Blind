import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Manually set up the Firebase mock platform
  FirebasePlatform.instance = MockFirebasePlatform();
}

Future<void> initializeMockFirebase() async {
  setupFirebaseMocks();
  await Firebase.initializeApp();
}

/// Mock implementation for Firebase Core
class MockFirebasePlatform extends FirebasePlatform {
  @override
  Future<FirebaseApp> initializeApp({String? name, FirebaseOptions? options}) async {
    return MockFirebaseApp();
  }
}

/// Manually created mock Firebase App (no Mockito auto-generation)
class MockFirebaseApp extends Fake implements FirebaseApp {}
