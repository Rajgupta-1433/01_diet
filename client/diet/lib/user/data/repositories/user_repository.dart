import 'package:dio/dio.dart';
import '../models/user_profile.dart';

class UserRepository {
  final String apiUrl = 'http://10.0.2.2:5000/api'; // Use 10.0.2.2 for Android emulator
  final Dio _dio;

  UserRepository(this._dio);

  Future<UserProfile> fetchUserProfile(String userId) async {
    try {
      final response = await _dio.get('$apiUrl/user-diet-details/$userId');
      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }
}
