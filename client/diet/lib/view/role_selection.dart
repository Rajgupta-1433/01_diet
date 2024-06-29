import 'package:flutter/material.dart';
import '../user/view/login_screen.dart';
import '../admin/view/admin_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Role"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("I'm a User"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginScreen()));
              },
              child: Text("I'm an Admin"),
            ),
          ],
        ),
      ),
    );
  }
}
