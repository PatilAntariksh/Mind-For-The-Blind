import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'screens/mode_selection.dart';

void main() {
  testWidgets('Mode selection screen shows all buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModeSelection()));

    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Video Navigation'), findsOneWidget);
    expect(find.text('Currency Detection'), findsOneWidget);
    expect(find.text('AI-Assistant'), findsOneWidget);
  });
}
