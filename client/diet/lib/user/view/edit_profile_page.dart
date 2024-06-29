import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../view_model/profile_view_model.dart';

class EditProfilePage extends ConsumerWidget {
  final String userId;

  const EditProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(profileViewModelProvider(userId));

    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController heightController = TextEditingController();
    final TextEditingController genderController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: false,
      ),
      body: userProfileAsyncValue.when(
        data: (userProfile) {
          nameController.text = userProfile.userName;
          ageController.text = userProfile.age.toString();
          weightController.text = userProfile.weight.toString();
          heightController.text = userProfile.height.toString();
          genderController.text = userProfile.gender;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String ageText = ageController.text;
                    final String weightText = weightController.text;
                    final String heightText = heightController.text;
                    final String gender = genderController.text;

                    if (name.isEmpty || ageText.isEmpty || weightText.isEmpty || heightText.isEmpty || gender.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All fields are required')),
                      );
                      return;
                    }

                    final int age = int.tryParse(ageText) ?? -1;
                    final int weight = int.tryParse(weightText) ?? -1;
                    final int height = int.tryParse(heightText) ?? -1;

                    if (age < 0 || weight < 0 || height < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter valid numeric values')),
                      );
                      return;
                    }

                    final Dio dio = Dio();
                    final String apiUrl = 'http://10.0.2.2:5000/api/user-preferences/$userId';

                    try {
                      final response = await dio.put(
                        apiUrl,
                        data: {
                          'user_name': name,
                          'age': age,
                          'weight': weight,
                          'height': height,
                          'gender': gender,
                        },
                      );

                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User preference updated successfully')),
                        );
                        // Update the state to reflect the changes
                        ref.refresh(profileViewModelProvider(userId));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update user preference')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  },
                  child: Text('Save'),
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
