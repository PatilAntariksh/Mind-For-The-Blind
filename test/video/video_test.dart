import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/video_call.dart';

void main() {
  testWidgets('Video Call screen loads', (WidgetTester tester) async {
    const testRoomId = 'test-room-123'; //  dummy room ID for test

    await tester.pumpWidget(
      const MaterialApp(
        home: VideoCallPage(roomId: testRoomId),
      ),
    );

    expect(find.text('Join Call'), findsOneWidget);
  });
}
