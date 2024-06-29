import 'package:diet/user/data/models/new_user_model.dart';
import 'package:diet/user/view_model/profile_view_model.dart';
import 'package:diet/view/user_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../data/models/user_new_model.dart';
import '../data/repositories/user_repository.dart';
// import 'user_main_page.dart';

class SummaryPage extends ConsumerWidget {
  final User user;
  final String name;
  final int age;
  final double height;
  final double weight;
  final String gender;

  SummaryPage({
    required this.user,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
  });

  double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double bmi = calculateBMI(weight, height);

    return Scaffold(
      appBar: AppBar(title: Text('Confirm Your Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name'),
            Text('Age: $age'),
            Text('Height: $height cm'),
            Text('Weight: $weight kg'),
            Text('Gender: $gender'),
            Text('BMI: ${bmi.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final userNewModel = UserNewModel(
                  userName: name,
                  age: age,
                  weight: weight,
                  height: height,
                  bmi: bmi,
                  gender: gender,
                );

                final userRepository = ref.read(userRepositoryProvider);
                try {
                  final String userId = await userRepository.addUserDietDetail(userNewModel);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('user_id', userId);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User diet detail added successfully, ID: $userId')),
                  );

                  // Navigate to the main user page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserMainPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add user diet detail')),
                  );
                }
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool loading = false;

//   void signUp() async {
//     setState(() {
//       loading = true;
//     });
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//       Navigator.pop(context); // Navigate back to login screen
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? 'An error occurred')),
//       );
//     } finally {
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Sign Up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: signUp,
//               child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
