import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_project/main.dart';

void main() {
  testWidgets('App launches and shows IntroPage', (WidgetTester tester) async {
    await tester.pumpWidget(CapstoneProjectApp());

    // Check that the app title or some text from IntroPage is visible
    expect(find.byType(MaterialApp), findsOneWidget);

    // Assuming your IntroPage contains some identifiable text like "Mind for the Blind"
    expect(find.text('Mind for the Blind'), findsOneWidget);
  });
}
