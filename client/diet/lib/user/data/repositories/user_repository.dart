import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/user_profile.dart';

class UserRepository {
  final String apiUrl = 'https://your-backend-api.com/api'; // Replace with your API URL
  final Dio _dio;

  UserRepository(this._dio);

  Future<UserProfile> fetchUserProfile(String userId) async {
    try {
      final response = await _dio.get('$apiUrl/user/$userId');

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
