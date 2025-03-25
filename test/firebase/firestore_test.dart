import 'package:flutter_test/flutter_test.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('Firestore Database Tests', () {
    late FakeFirebaseFirestore mockFirestore;

    setUp(() {
      mockFirestore = FakeFirebaseFirestore();
    });

    test('Firestore saves user data correctly', () async {
      final usersCollection = mockFirestore.collection("users");

      await usersCollection.doc("12345").set({
        "firstName": "John",
        "lastName": "Doe",
        "email": "john.doe@example.com"
      });

      final docSnapshot = await usersCollection.doc("12345").get();
      expect(docSnapshot.exists, true);
      expect(docSnapshot.data()?['firstName'], "John");
      expect(docSnapshot.data()?['email'], "john.doe@example.com");
    });
  });
}
