import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class FakeLoginPage extends StatelessWidget {
  const FakeLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(key: Key('emailField')),
          TextField(key: Key('passwordField')),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('Login page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FakeLoginPage()));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
