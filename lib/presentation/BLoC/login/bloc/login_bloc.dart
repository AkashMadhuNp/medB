import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medb/core/service/api_service.dart';
import 'package:medb/core/model/api_error_model.dart';

import 'login_event.dart';  
import 'login_state.dart';  

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService;

  LoginBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginReset>(_onLoginReset);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      print('Attempting login for: ${event.email}');

      final loginResponse = await _apiService.login(
        event.email.trim(),
        event.password.trim(),
      );

      print('Login successful for user: ${loginResponse.userDetails.firstName}');

      emit(LoginSuccess(
        userFirstName: loginResponse.userDetails.firstName,
        message: 'Welcome back, ${loginResponse.userDetails.firstName}!',
      ));
    } on ApiError catch (e) {
      print('API Error during login: ${e.message}');

      String errorMessage = e.message ?? 'Login failed';

      if (e.statuscode == 401) {
        errorMessage = 'Invalid email or password. Please try again.';
      } else if (e.statuscode == 403) {
        errorMessage = 'Please verify your email before logging in.';
      } else if (e.statuscode == 429) {
        errorMessage = 'Too many login attempts. Please try again later.';
      }

      emit(LoginFailure(
        errorMessage: errorMessage,
        statusCode: e.statuscode,
      ));
    } catch (e) {
      print('Unexpected error during login: $e');
      emit(LoginFailure(
        errorMessage: 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  void _onLoginReset(LoginReset event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}