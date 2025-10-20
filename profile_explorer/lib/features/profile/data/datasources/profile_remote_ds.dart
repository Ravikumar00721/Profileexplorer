import 'package:dio/dio.dart';
import '../../../../core/networking/dio_client.dart';
import '../models/user_profile.dart';



abstract class ProfileRemoteDataSource {
  Future<List<UserProfile>> fetchProfiles({int results = 20});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;
  ProfileRemoteDataSourceImpl([Dio? dio]) : _dio = dio ?? DioClient.instance;

  @override
  Future<List<UserProfile>> fetchProfiles({int results = 20}) async {
    final resp = await _dio.get('/api/', queryParameters: {'results': results});
    final list = (resp.data['results'] as List).cast<Map<String, dynamic>>();
    return list.map(UserProfile.fromRandomUser).toList(growable: false);
  }
}
