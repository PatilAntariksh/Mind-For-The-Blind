import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

/// Mock FirebaseAuth instance for testing
FirebaseAuth mockFirebaseAuth() {
  return MockFirebaseAuth();
}

/// Mock Firestore instance for testing
FirebaseFirestore mockFirestore() {
  return FakeFirebaseFirestore(); 
}
