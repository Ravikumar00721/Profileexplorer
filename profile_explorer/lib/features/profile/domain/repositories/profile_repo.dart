import '../../data/models/user_profile.dart';

abstract class ProfileRepository {
  Future<List<UserProfile>> fetchProfiles();
}
