import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/video_call.dart';

void main() {
  testWidgets('Video Call screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: VideoCallPage()));
    expect(find.text('Video Call'), findsOneWidget);
  });
}
