import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> with SingleTickerProviderStateMixin {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  String _userText = '';
  String _aiResponse = '';
  bool _isListening = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 500), () {
      _speakIntroMessage();
    });
  }

  Future<void> _speakIntroMessage() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);

    await _flutterTts.speak(
        "This is the AI Assistant screen. Tap the bottom button and speak your question. "
            "The assistant will listen and respond out loud."
    );
  }

  Future<void> _listen() async {
    print('[AI Assistant] Requesting mic permission...');
    if (await Permission.microphone.request().isGranted) {
      print('[AI Assistant] Initializing speech...');
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('[AI Assistant] Status: $status');
        },
        onError: (error) {
          print('[AI Assistant] Error: $error');
        },
      );

      print('[AI Assistant] Speech available: $available');

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          print('[AI Assistant] Recognized: ${result.recognizedWords}');
          setState(() => _userText = result.recognizedWords);

          if (!_speech.isListening) {
            print('[AI Assistant] Done listening. Sending to AI...');
            setState(() => _isListening = false);
            _sendToAI(_userText);
          }
        });
      } else {
        print('[AI Assistant] Speech not available.');
      }
    } else {
      print('[AI Assistant] Microphone permission denied.');
    }
  }

  Future<void> _sendToAI(String input) async {
    const endpoint = 'https://openrouter.ai/api/v1/chat/completions';
    const apiKey = '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';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'HTTP-Referer': '',
        'X-Title': 'MindForTheBlind Assistant'
      },
      body: json.encode({
        "model": "openai/gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": input}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String reply = data['choices'][0]['message']['content'];
      setState(() => _aiResponse = reply.trim());
      _speak(reply);
    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
      setState(() => _aiResponse = 'Error: AI service unavailable.');
      _speak('Sorry, I could not respond.');
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _speech.stop();
    _flutterTts.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('AI Assistant', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Press the mic and speak your question.',
                      style: TextStyle(color: Colors.black87),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  if (_isListening)
                    ScaleTransition(
                      scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      )),
                      child: const Icon(Icons.mic, size: 80, color: Colors.red),
                    )
                  else
                    const Icon(Icons.mic_none, size: 60, color: Colors.grey),
                  const SizedBox(height: 20),
                  Text('You said: $_userText',
                      style: const TextStyle(color: Colors.black87),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Text('AI says: $_aiResponse',
                      style: const TextStyle(color: Colors.teal),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.mic, size: 40),
              label: const Text(
                'Speak',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: _listen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
