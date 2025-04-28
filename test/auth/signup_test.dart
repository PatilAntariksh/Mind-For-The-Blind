import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class FakeSignUpPage extends StatelessWidget {
  const FakeSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(key: Key('emailField')),
          TextField(key: Key('passwordField')),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('Signup page UI renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FakeSignUpPage()));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
