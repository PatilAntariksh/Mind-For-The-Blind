import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFirebase extends Mock implements Firebase {}

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setupFirebaseCoreMocks();  // Mocks Firebase core methods
}

Future<void> initializeMockFirebase() async {
  setupFirebaseMocks();
  await Firebase.initializeApp();
}
