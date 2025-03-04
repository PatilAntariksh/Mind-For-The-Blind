import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedUserType = "Blind";

  bool isLoading = false;

  Future<void> _registerUser() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("All fields are required!", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "FirstName": firstName,
        "LastName": lastName,
        "email": email,
        "Password" : password,
        "userType": selectedUserType,
        "CreatedAt": FieldValue.serverTimestamp(),
      });

      _showMessage("User Registered Successfully! Redirecting...", Colors.green);

      // Redirect to WelcomePage after 5 seconds
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration failed";
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use!";
      } else if (e.code == 'weak-password') {
        errorMessage = "The password is too weak!";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format!";
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: firstNameController, decoration: InputDecoration(labelText: "First Name")),
            TextField(controller: lastNameController, decoration: InputDecoration(labelText: "Last Name")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),

            DropdownButton<String>(
              value: selectedUserType,
              items: ["Blind", "Helper"].map((String userType) {
                return DropdownMenuItem(value: userType, child: Text(userType));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUserType = value!;
                });
              },
            ),

            SizedBox(height: 20),

            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _registerUser,
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
