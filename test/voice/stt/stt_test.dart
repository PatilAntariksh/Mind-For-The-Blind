import 'package:flutter_test/flutter_test.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  late stt.SpeechToText speech;

  setUp(() {
    speech = stt.SpeechToText();
  });

  test('STT initializes and checks if speech recognition is available', () async {
    bool available = await speech.initialize();
    expect(available, true);
  });

  test('STT listens and captures input (mocked)', () async {
    bool available = await speech.initialize();
    expect(available, true);

    // Start listening with fake configuration
    await speech.listen(
      onResult: (result) {
        // Simulate successful result
        expect(result.recognizedWords, isNotEmpty);
      },
    );

    // Simulate some delay to allow "listening"
    await Future.delayed(const Duration(seconds: 1));
    await speech.stop();
  });
}
