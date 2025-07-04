import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/mode_selection.dart';

void main() {
  testWidgets('Mode selection screen shows all buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModeSelection()));

    await tester.pump(const Duration(milliseconds: 500)); // let TTS timer complete

    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Video Navigation'), findsOneWidget);
    expect(find.text('Currency Detection'), findsOneWidget);
    expect(find.text('AI-Assistant'), findsOneWidget);
  });
}
