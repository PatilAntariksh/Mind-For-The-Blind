// ignore_for_file: library_private_types_in_public_api, unnecessary_import

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'currency_classifier.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  late CurrencyClassifier classifier;
  String result = "Capture an image to classify";

  @override
  void initState() {
    super.initState();
    classifier = CurrencyClassifier();
    classifier.loadModel();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Uint8List imageBytes = await imageFile.readAsBytes();

      var prediction = classifier.classify(imageBytes);
      int predictedClass =
      prediction.indexOf(prediction.reduce((a, b) => a > b ? a : b));

      setState(() {
        result = "Predicted Currency: \$${getClassLabel(predictedClass)}";
      });
    }
  }

  /// Convert class index to currency labels
  String getClassLabel(int index) {
    List<String> labels = ["1", "5", "10", "20", "50", "100"];
    return labels[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Currency Recognition")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Capture Image"),
            ),
          ],
        ),
      ),
    );
  }
}
