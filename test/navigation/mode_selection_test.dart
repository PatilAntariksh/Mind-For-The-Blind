import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/screens/mode_selection.dart';
import '../mocks/mock_services.dart';

void main() {
  testWidgets('Mode Selection screen shows all mode buttons', (tester) async {
    final mockTts = MockFlutterTts();

    await tester.pumpWidget(const MaterialApp(home: ModeSelection()));

    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Video Navigation'), findsOneWidget);
    expect(find.text('Currency Detection'), findsOneWidget);
    expect(find.text('AI-Assistant'), findsOneWidget);
  });
}
