
import 'package:equatable/equatable.dart';
import 'package:medb/core/model/user_model.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  final UserModel user;

  const SignUpSubmitted({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignUpFormReset extends SignUpEvent {}
