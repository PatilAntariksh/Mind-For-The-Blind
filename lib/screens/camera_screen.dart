import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image/image.dart' as img;

import '../services/model_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController     _controller;
  bool                      _isReady     = false;
  img.Image?                _lastCaptured;
  String                    _resultText  = "Tap below to scan a note";
  final ModelService        _modelService= ModelService();
  final FlutterTts          _tts          = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // 1) load model & TTS
    await _modelService.loadModel();
    await _tts.setLanguage("en-US");

    // 2) grab first available camera
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller.initialize();

    if (!mounted) return;
    setState(() => _isReady = true);
  }

  Future<void> _scanNote() async {
    if (!_isReady) return;

    try {
      // 1) take a picture
      final file = await _controller.takePicture();
      final bytes = await File(file.path).readAsBytes();
      final decoded = img.decodeImage(bytes);

      if (decoded == null) {
        _resultText = "Could not decode image.";
        await _tts.speak(_resultText);
      } else {
        // 2) preprocess
        final resized = img.copyResize(decoded, width: 224, height: 224);
        final input = <List<List<List<double>>>>[
          List.generate(224, (y) {
            return List.generate(224, (x) {
              final px = resized.getPixel(x, y) as img.Pixel;
              return [
                px.r / 255.0,
                px.g / 255.0,
                px.b / 255.0,
              ];
            });
          }),
        ];

        // 3) inference
        final output = await _modelService.runInferenceOnImage(input);
        final probs  = output.first;
        final max    = probs.reduce((a, b) => a > b ? a : b);
        final idx    = probs.indexOf(max);
        final labels = ["1","5","10","20","50","100"];
        final label  = "\$${labels[idx]}";

        // 4) update UI & speak
        _lastCaptured = decoded;
        _resultText   = "Detected $label";
        await _tts.speak("Detected $label bill");
      }
    } catch (e) {
      _resultText = "Error: $e";
      await _tts.speak(_resultText);
    }

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Currency Scanner")),
      body: Column(
        children: [
          // ─── TOP HALF: live preview OR last captured ─────────────────────
          Expanded(
            child: Center(
              child: _lastCaptured != null
                  ? Image.memory(
                Uint8List.fromList(img.encodePng(_lastCaptured!)),
                fit: BoxFit.contain,
              )
                  : CameraPreview(_controller),
            ),
          ),

          // ─── RESULT TEXT ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _resultText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),

          // ─── BOTTOM HALF: giant scan button ────────────────────────────
          Expanded(
            child: Semantics(
              label: "Scan note",
              button: true,
              onTapHint: "Takes a photo of the note and announces its denomination",
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _scanNote,
                child: Container(
                  width: double.infinity,
                  color: Colors.blueGrey,
                  child: const Center(
                    child: Text(
                      "Tap Here to Scan a Note",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
