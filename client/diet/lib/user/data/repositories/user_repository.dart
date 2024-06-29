import 'package:diet/user/data/models/new_user_model.dart';
import 'package:diet/user/data/models/user_profile.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio;

  UserRepository(this.dio);

  Future<String> addUserDietDetail(UserNewModel userNewModel) async {
    final String apiUrl = 'http://10.0.2.2:5000/api/user-diet-details';
    try {
      print('Request Data: ${userNewModel.toMap()}'); // Log the request data
      final response = await dio.post(
        apiUrl,
        data: userNewModel.toMap(),
      );

      if (response.statusCode == 201) {
        return response.data['id'];  // Return the object ID
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Failed to add user diet detail');
      }
    } on DioException catch (e) {
      print('DioException: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      if (e.response?.data != null) {
        print('Response Data: ${e.response?.data}'); // Log the response data
      }
      throw Exception('Failed to add user diet detail: ${e.message}');
    }
  }

  Future<UserProfile> fetchUserProfile(String userId) async {
    final String apiUrl = 'http://10.0.2.2:5000/api/user-diet-details/$userId';
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load user profile: ${e.message}');
    }
  }
}




















// import 'package:diet/user/data/models/new_user_model.dart';
// import 'package:dio/dio.dart';
// // import '../models/user_new_model.dart';
// import '../models/user_profile.dart';

// class UserRepository {
//   final Dio dio;

//   UserRepository(this.dio);

//   Future<String> addUserDietDetail(UserNewModel userNewModel) async {
//     final String apiUrl = 'http://10.0.2.2:5000/api/user-diet-details';
//     try {
//       print('Request Data: ${userNewModel.toMap()}'); // Log the request data
//       final response = await dio.post(
//         apiUrl,
//         data: userNewModel.toMap(),
//       );

//       if (response.statusCode == 201) {
//         return response.data['id'];  // Return the object ID
//       } else {
//         print('Error: ${response.statusCode} - ${response.statusMessage}');
//         throw Exception('Failed to add user diet detail');
//       }
//     } on DioError catch (e) {
//       print('DioError: ${e.response?.statusCode} - ${e.response?.statusMessage}');
//       if (e.response?.data != null) {
//         print('Response Data: ${e.response?.data}'); // Log the response data
//       }
//       throw Exception('Failed to add user diet detail: ${e.message}');
//     }
//   }

//   Future<UserProfile> fetchUserProfile(String userId) async {
//     final String apiUrl = 'http://10.0.2.2:5000/api/user-diet-details/$userId';
//     try {
//       final response = await dio.get(apiUrl);

//       if (response.statusCode == 200) {
//         return UserProfile.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load user profile');
//       }
//     } on DioError catch (e) {
//       throw Exception('Failed to load user profile: ${e.message}');
//     }
//   }
// }















// // import 'package:diet/user/data/models/new_user_model.dart';
// // import 'package:dio/dio.dart';
// // // import '../models/user_new_model.dart';
// // import '../models/user_profile.dart';

// // class UserRepository {
// //   final Dio dio;

// //   UserRepository(this.dio);

// //   Future<String> addUserDietDetail(UserNewModel userNewModel) async {
// //     final String apiUrl = 'http://10.0.2.2:5000/api/user-diet-details';
// //     final response = await dio.post(
// //       apiUrl,
// //       data: userNewModel.toMap(),
// //     );

// //     if (response.statusCode == 201) {
// //       return response.data['id'];  // Return the object ID
// //     } else {
// //       throw Exception('Failed to add user diet detail');
// //     }
// //   }

// //   Future<UserProfile> fetchUserProfile(String userId) async {
// //     final String apiUrl = 'http://10.0.2.2:5000/api/user-diet-details/$userId';
// //     final response = await dio.get(apiUrl);

// //     if (response.statusCode == 200) {
// //       return UserProfile.fromJson(response.data);
// //     } else {
// //       throw Exception('Failed to load user profile');
// //     }
// //   }
// // }
