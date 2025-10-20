import 'package:dio/dio.dart';
import '../../../../core/utils/failure.dart';
import '../../domain/repositories/profile_repo.dart';
import '../datasources/profile_remote_ds.dart';
import '../models/user_profile.dart';



class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;
  ProfileRepositoryImpl(this.remote);

  @override
  Future<List<UserProfile>> fetchProfiles() async {
    try {
      return await remote.fetchProfiles();
    } on DioException catch (e) {
      throw NetworkFailure(e.message ?? 'Network error');
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
