import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:medb/core/model/api_error_model.dart';
import 'package:medb/core/model/user_model.dart';
import 'package:medb/core/model/login_response_model.dart';
import 'package:medb/core/service/auth_service.dart';

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

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final accessToken = AuthService.accessToken;
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {

        if (e.response?.statusCode == 401) {
          print('Access token expired (401). Session ended.');
          
          await AuthService.clearLoginData();
          
          ApiError apiError = ApiError(
            message: "Session expired. Please login again.",
            statuscode: 401,
          );
          
          handler.reject(DioException(
            requestOptions: e.requestOptions,
            error: apiError,
          ));
          return;
        }
        
        ApiError apiError = ApiError.fromDioException(e);
        handler.reject(DioException(
          requestOptions: e.requestOptions,
          error: apiError,
        ));
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false, 
      error: true,
    ));
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      
      final response = await _dio.post('/login', data: {
        'email': email.trim().toLowerCase(),
        'password': password,
      });


      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);
        
        await AuthService.storeLoginData(loginResponse);
        
        print('Login successful, data stored');
        return loginResponse;
      } else {
        throw ApiError(
          message: "Login failed: ${response.statusCode}",
          statuscode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      print('Login error: ${e.message}');
      
      if (e.error is ApiError) {
        throw e.error as ApiError;
      }
      
      String errorMessage = "Login failed";
      if (e.response?.data != null && e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Connection timeout. Check your internet connection.";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Request timeout. Please try again.";
      }

      throw ApiError(
        message: errorMessage,
        statuscode: e.response?.statusCode,
      );
    } catch (e) {
      print('Unexpected login error: $e');
      throw ApiError(message: "An unexpected error occurred");
    }
  }

  Future<String> register(UserModel user) async {
    try {
      print('Registering user');
      
      final response = await _dio.post('/register', data: user.toJson());
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["message"] as String;
      } else {
        throw ApiError(
          message: "Registration failed: ${response.statusCode}",
          statuscode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      print('Registration error: ${e.message}');
      
      if (e.error is ApiError) {
        throw e.error as ApiError;
      }
      
      String errorMessage = "Registration failed";
      if (e.response?.data != null && e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }

      throw ApiError(
        message: errorMessage,
        statuscode: e.response?.statusCode,
      );
    } catch (e) {
      print('Unexpected registration error: $e');
      throw ApiError(message: "An unexpected error occurred");
    }
  }

  Future<String> logout() async {
    try {
      print('Attempting logout...');
      
      final response = await _dio.post('/logout');
      
      await AuthService.clearLoginData();
      
      if (response.statusCode == 200) {
        return response.data["message"] ?? "Logged out successfully";
      } else {
        return "Logged out successfully";
      }
    } catch (e) {
      print('Logout error (clearing local data anyway): $e');
      
      await AuthService.clearLoginData();
      
      return "Logged out successfully";
    }
  }

  Future<Response> authenticatedRequest(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(method: method);
      
      switch (method.toUpperCase()) {
        case 'GET':
          return await _dio.get(path, queryParameters: queryParameters, options: options);
        case 'POST':
          return await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
        case 'PUT':
          return await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
        case 'DELETE':
          return await _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
        default:
          throw ApiError(message: "Unsupported HTTP method: $method");
      }
    } on DioException catch (e) {
      if (e.error is ApiError) {
        throw e.error as ApiError;
      } else {
        throw ApiError.fromDioException(e);
      }
    }
  }
}