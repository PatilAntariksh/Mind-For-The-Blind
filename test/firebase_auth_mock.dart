import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

/// Returns a mock instance of FirebaseAuth to be used in tests.
FirebaseAuth mockFirebaseAuth() {
  return MockFirebaseAuth();
}
