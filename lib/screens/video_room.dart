import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:capstone_project/screens/video_call.dart';

class VideoRoomPage extends StatefulWidget {
  const VideoRoomPage({super.key});

  @override
  State<VideoRoomPage> createState() => _VideoRoomPageState();
}

class _VideoRoomPageState extends State<VideoRoomPage> {
  final TextEditingController _roomIdController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _speakScreenInstructions();
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    _speech.stop();
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _speakScreenInstructions() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);

    await _flutterTts.speak(
      "This is the video room screen. "
          "Tap anywhere on the upper half to speak your room ID using the microphone. "
          "Tap anywhere on the bottom half to press the Join Call button to enter the room.",
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _roomIdController.text = result.recognizedWords;
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _joinCall() {
    final roomId = _roomIdController.text.trim();
    if (roomId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCallPage(roomId: roomId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Room ID")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Join Video Call")),
      body: Column(
        children: [
          // 🔝 Full Top Half - Tappable Mic Button
          GestureDetector(
            onTap: _listen,
            child: Container(
              height: height * 0.4,
              width: double.infinity,
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 64,
                  color: _isListening ? Colors.red : Colors.blue,
                ),
              ),
            ),
          ),

          // 🎤 Middle - TextField for Room ID
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: _roomIdController,
              decoration: const InputDecoration(
                hintText: "Enter Room ID",
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),

          const SizedBox(height: 20),

          // 🔻 Bottom Join Button
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton.icon(
                onPressed: _joinCall,
                icon: const Icon(Icons.video_call),
                label: const Text("Join Call", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
