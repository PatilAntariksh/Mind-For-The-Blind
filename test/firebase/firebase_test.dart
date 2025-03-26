import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  group('Firebase Authentication Tests', () {
    late MockFirebaseAuth mockAuth;

    setUp(() {
      mockAuth = MockFirebaseAuth();
    });

    test('User can sign up successfully', () async {
      final result = await mockAuth.createUserWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      expect(result.user, isNotNull);
      expect(result.user?.email, "test@example.com");
    });

    test('User can log in successfully', () async {
      // First, create the user.
      await mockAuth.createUserWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      final result = await mockAuth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      expect(result.user, isNotNull);
      expect(result.user?.email, "test@example.com");
    });

    test('Current user should be correct after login', () async {
      // Ensure a user exists by creating one first.
      await mockAuth.createUserWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      final result = await mockAuth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      // Verify the returned user.
      expect(result.user, isNotNull);
      expect(result.user?.email, "test@example.com");
    });

    test('Signing out removes current user', () async {
      await mockAuth.createUserWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      await mockAuth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "password123",
      );

      await mockAuth.signOut();
      expect(mockAuth.currentUser, isNull);
    });
  });
}
