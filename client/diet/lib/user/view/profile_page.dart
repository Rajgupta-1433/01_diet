import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../view_model/profile_view_model.dart';
import '../data/models/user_profile.dart';
import 'login_screen.dart';
import 'package:diet/widgets/button.dart'; // Ensure this path is correct

class ProfilePage extends ConsumerWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(userProfileProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: userProfileAsyncValue.when(
        data: (userProfile) {
          final bmi = userProfile.weight / ((userProfile.height / 100) * (userProfile.height / 100));

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${userProfile.name}'),
                Text('Age: ${userProfile.age}'),
                Text('Weight: ${userProfile.weight} kg'),
                Text('Height: ${userProfile.height} cm'),
                Text('Gender: ${userProfile.gender}'),
                Text('BMI: ${bmi.toStringAsFixed(2)}'),
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Center(child: Text('Failed to load profile')),
      ),
    );
  }
}



















// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'login_screen.dart';
// // import 'package:diet/widgets/button.dart'; // Ensure this path is correct

// import 'package:diet/user/view/login_screen.dart';
// import 'package:diet/widgets/button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   void _logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Profile Page Content'),
//             const SizedBox(height: 20),
//             CustomButton(
//               text: 'Logout',
//               onPressed: () => _logout(context),
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               borderRadius: 8.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }