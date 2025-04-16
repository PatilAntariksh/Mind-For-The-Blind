import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class VideoChatScreen extends StatefulWidget {
  @override
  _VideoChatScreenState createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  final TextEditingController _roomController = TextEditingController();

  void _joinMeeting(String roomName) async {
    final options = JitsiMeetingOptions(
      roomNameOrUrl: roomName,
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "disableInviteFunctions": true,
      },
      featureFlags: {
        "invite.enabled": false,
      },
    );

    try {
      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      debugPrint("Error: $error");
    }
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Video Chat Room")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _roomController,
              decoration: InputDecoration(labelText: "Enter Room Keyword"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_roomController.text.trim().isNotEmpty) {
                  _joinMeeting(_roomController.text.trim());
                }
              },
              child: Text("Join Video Chat"),
            ),
          ],
        ),
      ),
    );
  }
}
