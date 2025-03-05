import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Register the mock Firebase platform
  FirebasePlatform.instance = MockFirebasePlatform();
}

Future<void> initializeMockFirebase() async {
  setupFirebaseMocks();
  await Firebase.initializeApp();
}

/// Mock Firebase Platform Implementation
class MockFirebasePlatform extends FirebasePlatform {
  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return MockFirebaseAppPlatform();
  }
}

/// Mock Firebase App Platform (ensures correct return type)
class MockFirebaseAppPlatform extends FirebaseAppPlatform {
  MockFirebaseAppPlatform() : super('mockApp');

  @override
  FirebaseOptions get options => FirebaseOptions(
        apiKey: "fakeApiKey",
        appId: "fakeAppId",
        messagingSenderId: "fakeSenderId",
        projectId: "fakeProjectId",
      );
}
