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
    final userProfileAsyncValue = ref.watch(profileViewModelProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: false,
        actions: [
          Icon(Icons.edit),
        ],
        
      ),
      body: userProfileAsyncValue.when(
        data: (userProfile) {
          final bmi = userProfile.weight /
              ((userProfile.height / 100) * (userProfile.height / 100));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Name'),
                  subtitle: Text(userProfile.userName),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Age'),
                  subtitle: Text('${userProfile.age} years'),
                ),
                ListTile(
                  leading: Icon(Icons.monitor_weight),
                  title: Text('Weight'),
                  subtitle: Text('${userProfile.weight} kg'),
                ),
                ListTile(
                  leading: Icon(Icons.height),
                  title: Text('Height'),
                  subtitle: Text('${userProfile.height} cm'),
                ),
                ListTile(
                  leading: Icon(Icons.male),
                  title: Text('Gender'),
                  subtitle: Text(userProfile.gender),
                ),
                ListTile(
                  leading: Icon(Icons.fitness_center),
                  title: Text('BMI'),
                  subtitle: Text(bmi.toStringAsFixed(2)),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomButton(
                    text: 'Logout',
                    onPressed: () => _logout(context),
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    borderRadius: 8.0,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Failed to load profile: $err')),
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