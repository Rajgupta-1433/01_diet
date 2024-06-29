// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_screen.dart';
// import 'package:diet/widgets/button.dart'; // Ensure this path is correct

import 'package:diet/user/view/login_screen.dart';
import 'package:diet/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Page Content'),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Logout',
              onPressed: () => _logout(context),
              backgroundColor: Colors.red,
              textColor: Colors.white,
              borderRadius: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}