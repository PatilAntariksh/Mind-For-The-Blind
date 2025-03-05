import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';


class MockFirebaseCore extends FirebasePlatform {
  @override
  Future<FirebaseApp> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return FirebaseApp.instance;
  }
}


void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FirebasePlatform.instance = MockFirebaseCore();  // Use the mock implementation
}


Future<void> initializeMockFirebase() async {
  setupFirebaseMocks();
  await Firebase.initializeApp();  
}
