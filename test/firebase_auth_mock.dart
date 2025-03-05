import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseAuthMocks() {
  final mockAuth = MockFirebaseAuth();
  FirebaseAuth.instanceFor(app: Firebase.app()) ?? mockAuth;
}
