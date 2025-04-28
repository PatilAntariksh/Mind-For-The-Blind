import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/video_call.dart';

void main() {
  testWidgets('VideoCallPage loads with room ID', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: VideoCallPage(roomId: 'testroom'),
      ),
    );

    expect(find.byType(VideoCallPage), findsOneWidget);
  });
}
