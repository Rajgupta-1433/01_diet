import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../data/models/user_profile.dart';
import '../data/repositories/user_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.read(dioProvider));
});

final userProfileProvider = FutureProvider.family<UserProfile, String>((ref, userId) {
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.fetchUserProfile(userId);
});

class ProfileViewModel extends StateNotifier<AsyncValue<UserProfile>> {
  final String userId;
  final UserRepository userRepository;

  ProfileViewModel({required this.userId, required this.userRepository})
      : super(const AsyncValue.loading()) {
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final userProfile = await userRepository.fetchUserProfile(userId);
      print('User Profile fetched: ${userProfile.toJson()}'); // Logging the user profile
      state = AsyncValue.data(userProfile);
    } catch (e, stackTrace) {
      print('Error fetching user profile: $e'); // Logging the error
      state = AsyncValue.error(e, stackTrace);
    }
  }

  double calculateBMI() {
    final userProfile = state.value;
    if (userProfile != null) {
      return userProfile.weight / ((userProfile.height / 100) * (userProfile.height / 100));
    }
    return 0.0;
  }
}

final profileViewModelProvider = StateNotifierProvider.family<ProfileViewModel, AsyncValue<UserProfile>, String>((ref, userId) {
  final userRepository = ref.read(userRepositoryProvider);
  return ProfileViewModel(userId: userId, userRepository: userRepository);
});
