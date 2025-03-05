import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

/// Mock FirebaseAuth instance for testing
FirebaseAuth mockFirebaseAuth() {
  return MockFirebaseAuth();
}

/// Mock Firestore instance for testing
FirebaseFirestore mockFirestore() {
  return MockFirestoreInstance();
}
