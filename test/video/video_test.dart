import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/video_call.dart';

void main() {
  testWidgets('VideoCallPage loads successfully with a room ID', (tester) async {
    const testRoomId = 'demo-room';
    await tester.pumpWidget(MaterialApp(home: VideoCallPage(roomId: testRoomId)));

    expect(find.byType(VideoCallPage), findsOneWidget);
  });
}
