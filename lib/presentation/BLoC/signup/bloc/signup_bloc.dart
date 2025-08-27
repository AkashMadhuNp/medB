import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medb/core/model/api_error_model.dart';
import 'package:medb/core/service/api_service.dart';
import 'package:medb/presentation/BLoC/signup/bloc/signup_event.dart';
import 'package:medb/presentation/BLoC/signup/bloc/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final ApiService _apiService;

  SignUpBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignUpFormReset>(_onSignUpFormReset);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    try {
      final message = await _apiService.register(event.user);
      emit(SignUpSuccess(
        message: '$message Please verify your email before logging in',
      ));
    } on ApiError catch (e) {
      emit(SignUpFailure(errorMessage: e.message));
    } catch (e) {
      emit(SignUpFailure(errorMessage: 'An unexpected error occurred'));
    }
  }

  void _onSignUpFormReset(
    SignUpFormReset event,
    Emitter<SignUpState> emit,
  ) {
    emit(SignUpInitial());
  }
}
