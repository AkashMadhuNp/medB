import 'package:dio/dio.dart';

class ApiError{
  final String message;
  final int? statuscode;

  ApiError({
    required this.message,
    this.statuscode
  });

  factory ApiError.fromDioException(DioException e){
    if(e.response != null && e.response?.data != null){
      return ApiError(
        message:e.response?.data['message'] ?? "Unknown API error",
        statuscode: e.response?.statusCode, 
        );
    }else{
      return ApiError(
        message: e.message ?? "Network Error",
        statuscode: e.response?.statusCode,
        );
    }
  }

  @override
  String toString()=>message;
}