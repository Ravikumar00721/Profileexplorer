import 'package:dio/dio.dart';

class DioClient {
  DioClient._();
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://randomuser.me',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 20),
  ));

  static Dio get instance => _dio;
}
