import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminSignupScreen extends StatefulWidget {
  const AdminSignupScreen({super.key});

  @override
  _AdminSignupScreenState createState() => _AdminSignupScreenState();
}

class _AdminSignupScreenState extends State<AdminSignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void signUp() async {
    setState(() {
      loading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context); // Navigate back to login screen
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
