import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication auth = LocalAuthentication();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool showBiometricButton = false;

  @override
  void initState() {
    super.initState();
    _prepareBiometric(); // auto trigger
  }

  Future<void> _prepareBiometric() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    final canCheck = await auth.canCheckBiometrics;
    final isSupported = await auth.isDeviceSupported();

    if (canCheck && isSupported && email.isNotEmpty && password.isNotEmpty) {
      setState(() => showBiometricButton = true);
      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Authenticate to log in',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        emailController.text = email;
        passwordController.text = password;
        _loginUser(bypassInput: true);
      }
    }
  }

  Future<void> _loginUser({bool bypassInput = false}) async {
    String email = bypassInput ? emailController.text : emailController.text.trim();
    String password = bypassInput ? passwordController.text : passwordController.text.trim();

    if (!bypassInput && (email.isEmpty || password.isEmpty)) {
      _showMessage("Both email and password are required!", Colors.red);
      return;
    }

    setState(() => isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('password', password);

      _showMessage("Login Successful! Redirecting...", Colors.green);
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/mode_selection');
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      }
      _showMessage(errorMessage, Colors.red);
    } catch (e) {
      _showMessage("Error: ${e.toString()}", Colors.red);
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () => _loginUser(),
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            // Optional manual biometric login button (only shows if supported)
            if (showBiometricButton)
              ElevatedButton.icon(
                onPressed: _prepareBiometric,
                icon: const Icon(Icons.fingerprint),
                label: const Text("Login with Biometrics"),
              ),
          ],
        ),
      ),
    );
  }
}
