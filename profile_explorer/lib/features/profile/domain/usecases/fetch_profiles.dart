import '../repositories/profile_repo.dart';
import '../entities/user_entity.dart';

class FetchProfiles {
  final ProfileRepository repo;
  FetchProfiles(this.repo);
  Future<List<UserEntity>> call() => repo.fetchProfiles();
}
