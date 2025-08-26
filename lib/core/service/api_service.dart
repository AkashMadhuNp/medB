import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:medb/core/model/api_error_model.dart';
import 'package:medb/core/model/user_model.dart';

class ApiService {
  late Dio _dio;
  late CookieJar _cookieJar;

  static const String baseUrl = 'https://testapi.medb.co.in/api/auth'; 

  ApiService() {
    _cookieJar = CookieJar();
    
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(CookieManager(_cookieJar));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      error: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) {
        print('DioException: ${e.message}');
        print('Response data: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        
        ApiError apiError = ApiError.fromDioException(e);
        handler.reject(DioException(
          requestOptions: e.requestOptions,
          error: apiError,
        ));
      },
    ));
  }

  Future<String> register(UserModel user) async {
    try {
      print('Registering user: ${user.toJson()}'); 

      final response = await _dio.post('/register', data: user.toJson());

      print('Registration response: ${response.data}'); 

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["message"] as String;
      } else {
        throw ApiError(
          message: "Unexpected error: ${response.statusCode}",
          statuscode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      print('DioException caught in register: ${e.message}');
      
      if (e.error is ApiError) {
        throw e.error as ApiError;
      } else {
        String errorMessage;
        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Connection timeout. Please check your internet connection.";
        } else if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = "Request timeout. Please try again.";
        } else if (e.response?.data != null && e.response?.data is Map) {
          errorMessage = e.response?.data['message'] ?? "Registration failed";
        } else {
          errorMessage = e.message ?? "Network error occurred";
        }
        
        throw ApiError(
          message: errorMessage,
          statuscode: e.response?.statusCode,
        );
      }
    } catch (e) {
      print('General exception in register: $e');
      throw ApiError(message: "An unexpected error occurred: ${e.toString()}");
    }
  }

  
}