import 'package:diet/admin/view/admin_login_screen.dart';
import 'package:diet/view/user_main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart';
// import 'user_main_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  void login() async {
    setState(() {
      loading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if the user is an admin
      if (emailController.text.contains("admin")) {
        // Admin login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminLoginScreen()),
        );
      } else {
        // User login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserMainPage()),
        );
      }
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
        title: Text('User Login'),
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
              onPressed: login,
              child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
