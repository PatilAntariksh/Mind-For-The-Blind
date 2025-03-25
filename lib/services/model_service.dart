import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:flutter/services.dart' show rootBundle;
import 'package:tflite_flutter/tflite_flutter.dart';

class ModelService {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    try {
      // 1) Load the raw .tflite bytes from assets
      final modelData = await rootBundle.load('assets/model/currency_model.tflite');
      debugPrint("Model file size: ${modelData.lengthInBytes} bytes");

      // 2) Convert the file data to a Uint8List buffer
      final buffer = modelData.buffer.asUint8List();

      // 3) Create the interpreter from the buffer
      _interpreter = Interpreter.fromBuffer(buffer);
      debugPrint("Model loaded successfully from buffer.");
    } catch (e) {
      debugPrint("Error loading model: $e");
      rethrow;
    }
  }

  Future<List<List<double>>> runInferenceOnImage(
      List<List<List<List<double>>>> input) async {
    if (_interpreter == null) {
      throw Exception("Model not loaded.");
    }
    var output = List.generate(1, (_) => List.filled(6, 0.0));
    _interpreter!.run(input, output);
    return output;
  }
}
