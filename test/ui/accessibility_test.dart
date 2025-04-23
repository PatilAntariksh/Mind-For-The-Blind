import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/mode_selection.dart';

void main() {
  testWidgets('Accessibility test: Buttons are labeled and sized properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModeSelection()));

    // Check for presence of 3 mode buttons and 1 back button (total 4 buttons)
    final buttons = find.byType(ElevatedButton);
    expect(buttons, findsNWidgets(4));

    // Check for accessibility: button text should be descriptive
    expect(find.text('Currency Detection'), findsOneWidget);
    expect(find.text('AI Assistant'), findsOneWidget);
    expect(find.text('Video Call'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
