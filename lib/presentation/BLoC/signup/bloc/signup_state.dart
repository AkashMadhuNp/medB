import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;

  const SignUpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends SignUpState {
  final String errorMessage;

  const SignUpFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
