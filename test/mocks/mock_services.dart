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
    dynamic authMessages, // <- instead of List<AuthMessages> to avoid import errors
    dynamic options, // <- this covers any new parameters
  }) async => true;

  @override
  Future<bool> get canCheckBiometrics async => true;

  @override
  Future<bool> isDeviceSupported() async => true;
}
