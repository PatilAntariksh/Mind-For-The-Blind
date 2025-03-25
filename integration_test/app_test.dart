import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capstone_project/main.dart';
import 'package:capstone_project/screens/welcome_page.dart';
import 'package:capstone_project/screens/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app flow: Splash -> Welcome -> Login', (WidgetTester tester) async {
    await tester.pumpWidget(CapstoneProjectApp());
    await tester.pumpAndSettle();

    // Ensure the WelcomePage is displayed
    expect(find.byType(WelcomePage), findsOneWidget);

    // Tap on "Login" button
    await tester.tap(find.text("Login"));
    await tester.pumpAndSettle();

    // Ensure LoginPage appears
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
