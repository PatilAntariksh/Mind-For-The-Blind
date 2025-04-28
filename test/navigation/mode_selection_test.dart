import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/mode_selection.dart';

void main() {
  testWidgets('Mode Selection screen has all accessible buttons', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModeSelectionPage()));

    expect(find.text('Video Navigation'), findsOneWidget);
    expect(find.text('Currency Detection'), findsOneWidget);
    expect(find.text('AI Assistant'), findsOneWidget);
    expect(find.text('Video Call'), findsOneWidget);
  });
}
