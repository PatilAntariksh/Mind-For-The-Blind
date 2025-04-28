import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:local_auth/local_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFlutterTts extends Mock implements FlutterTts {
  @override
  Future<dynamic> speak(String text) async => Future.value();

  @override
  Future<dynamic> stop() async => Future.value();
}

class MockLocalAuth extends Mock implements LocalAuthentication {
  @override
  Future<bool> authenticate({
    required String localizedReason,
    bool biometricOnly = false,
    bool useErrorDialogs = true,
    bool stickyAuth = false,
    List<AuthMessages>? authMessages, // <--- Add this optional parameter!
  }) async => true;

  @override
  Future<bool> get canCheckBiometrics async => true; // <-- FIXED: Now it's a getter!

  @override
  Future<bool> isDeviceSupported() async => true;
}
