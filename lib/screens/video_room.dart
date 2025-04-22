import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'video_call.dart';

class VideoRoomPage extends StatefulWidget {
  const VideoRoomPage({super.key});

  @override
  State<VideoRoomPage> createState() => _VideoRoomPageState();
}

class _VideoRoomPageState extends State<VideoRoomPage> {
  final TextEditingController _roomIdController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      _speakScreenInstructions();
    });
  }

  Future<void> _speakScreenInstructions() async {
    await flutterTts.stop();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);

    await flutterTts.speak(
      "This is the video room screen. Tap anywhere on the top half to speak the room ID. Enter a room ID in the middle box. Then tap the bottom half to join the video call.",
    );
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _logUserToRoom(String roomId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final userData = userDoc.data();
    final name = userData?['firstName'];
    final email = userData?['email'];
    final userType = userData?['userType'];

    final docRef = FirebaseFirestore.instance
        .collection('video_calls')
        .doc(roomId);

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.update({
        'callers.names': FieldValue.arrayUnion([name]),
        'callers.emails': FieldValue.arrayUnion([email]),
        'callers.userTypes': FieldValue.arrayUnion([userType]),
      });
    } else {
      await docRef.set({
        'roomId': roomId,
        'timestamp': DateTime.now(),
        'callers': {
          'names': [name],
          'emails': [email],
          'userTypes': [userType],
        }
      });
    }
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

  void _joinCall() async {
    final roomId = _roomIdController.text.trim();
    if (roomId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Room ID")),
      );
      return;
    }

    await _logUserToRoom(roomId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallPage(roomId: roomId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Join Video Call")),
      body: Column(
        children: [
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
          const SizedBox(height: 24),
          Expanded(
            child: GestureDetector(
              onTap: _joinCall,
              child: Container(
                width: double.infinity,
                color: Colors.blueAccent,
                child: const Center(
                  child: Text(
                    "Join Call",
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
