import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:capstone_project/services/model_service.dart';
import 'package:image/image.dart' as img;

class TestInferenceScreen extends StatefulWidget {
  const TestInferenceScreen({super.key});

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
    debugPrint("Model loaded successfully.");

    // 2) Load a sample image from assets
    final byteData = await rootBundle.load('assets/images/1_Dollar_Sample.png');
    final imageBytes = byteData.buffer.asUint8List();
    _sampleImage = img.decodeImage(imageBytes);
    if (_sampleImage == null) {
      setState(() => _inferenceResult = "Failed to decode sample image.");
      return;
    }

    // 3) Preprocess the image
    final resized = img.copyResize(_sampleImage!, width: 224, height: 224);
    final input = [
      List.generate(224, (y) {
        return List.generate(224, (x) {
          final pixel = resized.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;
          return [r, g, b];
        });
      })
    ];

    // 4) Run inference
    try {
      final output = await _modelService.runInferenceOnImage(input);
      final probabilities = output[0]; // e.g., [0.74, 0.01, ...]

      // Find the highest probability and index
      double maxProb = probabilities.reduce((a, b) => a > b ? a : b);
      int maxIndex = probabilities.indexOf(maxProb);

      // Map to labels
      List<String> denominations = ["1", "5", "10", "20", "50", "100"];
      String predictedDenomination = denominations[maxIndex];

      // Build result string
      String resultString = "Predicted Denomination: \$$predictedDenomination\n"
          "Confidence: ${maxProb.toStringAsFixed(2)}";

      setState(() => _inferenceResult = resultString);
      debugPrint("Inference output: $output");
    } catch (e) {
      setState(() => _inferenceResult = "Error: $e");
      debugPrint("Inference error: $e");
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
