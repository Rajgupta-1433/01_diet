import 'package:diet/view/admin_main_page.dart';
import 'package:diet/view/role_selection.dart';
import 'package:diet/view/user_main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'role_selection_screen.dart';
import '../user/view/login_screen.dart';
// import '../admin/view/admin_main_page.dart';
// import '../user/view/user_main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // Assume you have a method to check if the user is an admin
      bool isAdmin = await checkIfUserIsAdmin(user);
      if (isAdmin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminMainPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserMainPage()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
      );
    }
  }

  Future<bool> checkIfUserIsAdmin(User user) async {
    // Implement your logic to check if the user is an admin
    return false; // Placeholder implementation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Diet App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
