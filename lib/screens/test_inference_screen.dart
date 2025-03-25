import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:capstone_project/services/model_service.dart'; // Make sure this file exists in lib/services/model_service.dart
import 'package:image/image.dart' as img; // Using image: ^4.1.3

class TestInferenceScreen extends StatefulWidget {
  const TestInferenceScreen({Key? key}) : super(key: key);

  @override
  State<TestInferenceScreen> createState() => _TestInferenceScreenState();
}

class _TestInferenceScreenState extends State<TestInferenceScreen> {
  final ModelService _modelService = ModelService();
  String _inferenceResult = "Waiting for inference...";
  img.Image? _sampleImage;

  @override
  void initState() {
    super.initState();
    _loadModelAndRunInference();
  }

  Future<void> _loadModelAndRunInference() async {
    // 1) Load your TFLite model
    await _modelService.loadModel();
    print("Model loaded successfully.");

    // 2) Load a sample image from assets (declared in pubspec.yaml)
    final byteData = await rootBundle.load('assets/images/1_Dollar_Sample.png');
    final imageBytes = byteData.buffer.asUint8List();
    _sampleImage = img.decodeImage(imageBytes);
    if (_sampleImage == null) {
      setState(() => _inferenceResult = "Failed to decode sample image.");
      return;
    }

    // 3) Preprocess the image (resize to 224x224, normalize pixel values)
    final resized = img.copyResize(_sampleImage!, width: 224, height: 224);
    List<List<List<List<double>>>> input = [
      List.generate(224, (y) {
        return List.generate(224, (x) {
          // 'getPixel' returns a Pixel object in image: ^4.1.3
          final pixel = resized.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;
          return [r, g, b];
        });
      })
    ];

    // 4) Run inference using the model service
    try {
      final output = await _modelService.runInferenceOnImage(input);
      // output is [ [p1, p2, p3, p4, p5, p6] ]
      final probabilities = output[0]; // e.g., [0.74, 0.01, 0.00, 0.21, 0.02, 0.02]

      // Find the highest probability and its index
      double maxProb = probabilities.reduce((a, b) => a > b ? a : b);
      int maxIndex = probabilities.indexOf(maxProb);

      // Map index to your currency denominations
      List<String> denominations = ["1", "5", "10", "20", "50", "100"];
      String predictedDenomination = denominations[maxIndex];

      // Build a user-friendly result string
      String resultString = "Predicted Denomination: \$${predictedDenomination}\n"
          "Confidence: ${maxProb.toStringAsFixed(2)}";

      setState(() => _inferenceResult = resultString);
      print("Inference output: $output");
    } catch (e) {
      setState(() => _inferenceResult = "Error: $e");
      print("Inference error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Inference"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Show the sample image or a loading spinner
            _sampleImage != null
                ? Image.memory(
              img.encodePng(_sampleImage!),
              width: 200,
              height: 200,
            )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text("Inference Result:"),
            Text(
              _inferenceResult,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
