abstract class LoginState {}


class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String userFirstName;
  final String message;

  LoginSuccess({
    required this.userFirstName,
    required this.message,
  });
}



class LoginFailure extends LoginState {
  final String errorMessage;
  final int? statusCode;

  LoginFailure({
    required this.errorMessage,
    this.statusCode,
  });
}
