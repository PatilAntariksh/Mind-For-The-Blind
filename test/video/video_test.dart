import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/video_call.dart';

void main() {
  testWidgets('VideoCallPage loads with a valid roomId', (tester) async {
    const roomId = 'demo-room';
    await tester.pumpWidget(
      MaterialApp(
        home: VideoCallPage(roomId: roomId),
      ),
    );

    expect(find.byType(VideoCallPage), findsOneWidget);
  });
}
