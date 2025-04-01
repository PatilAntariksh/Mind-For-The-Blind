import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Both email and password are required!", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _showMessage("Login Successful! Redirecting...", Colors.green);

      // Use await instead of callback to avoid holding onto context for 3s
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return; // Check if the widget is still in the tree

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

    setState(() {
      isLoading = false;
    });
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
              onPressed: _loginUser,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
