import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BaseLayoutState extends Equatable {
  const BaseLayoutState();

  @override
  List<Object?> get props => [];
}


class BaseLayoutInitial extends BaseLayoutState {
  const BaseLayoutInitial();
}



class BaseLayoutLoading extends BaseLayoutState {
  const BaseLayoutLoading();
}



class NavigationState extends BaseLayoutState {
  final Widget? targetScreen;
  final String screenName;

  const NavigationState({
    required this.targetScreen,
    required this.screenName,
  });

  @override
  List<Object?> get props => [targetScreen, screenName];
}



class ComingSoonState extends BaseLayoutState {
  final String screenName;

  const ComingSoonState({required this.screenName});

  @override
  List<Object?> get props => [screenName];
}



class LogoutDialogState extends BaseLayoutState {
  const LogoutDialogState();
}



class LogoutLoadingState extends BaseLayoutState {
  const LogoutLoadingState();
}



class LogoutSuccessState extends BaseLayoutState {
  const LogoutSuccessState();
}



class LogoutErrorState extends BaseLayoutState {
  final String error;

  const LogoutErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}



class NotificationState extends BaseLayoutState {
  const NotificationState();
}
