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

class ProfileViewModel extends StateNotifier<UserProfile?> {
  final String userId;
  final UserRepository userRepository;

  ProfileViewModel({required this.userId, required this.userRepository}) : super(null);

  Future<void> fetchUserProfile() async {
    state = await userRepository.fetchUserProfile(userId);
  }

  double calculateBMI() {
    if (state != null) {
      return state!.weight / ((state!.height / 100) * (state!.height / 100));
    }
    return 0.0;
  }
}

final profileViewModelProvider = StateNotifierProvider.family<ProfileViewModel, UserProfile?, String>((ref, userId) {
  final userRepository = ref.read(userRepositoryProvider);
  return ProfileViewModel(userId: userId, userRepository: userRepository);
});
