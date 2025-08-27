import 'package:equatable/equatable.dart';

abstract class BaseLayoutEvent extends Equatable {
  const BaseLayoutEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToScreenEvent extends BaseLayoutEvent {
  final String screenName;
  final String route;

  const NavigateToScreenEvent({
    required this.screenName,
    required this.route,
  });

  @override
  List<Object?> get props => [screenName, route];
}

class LogoutRequestedEvent extends BaseLayoutEvent {
  const LogoutRequestedEvent();
}

class LogoutConfirmedEvent extends BaseLayoutEvent {
  const LogoutConfirmedEvent();
}

class LogoutCancelledEvent extends BaseLayoutEvent {
  const LogoutCancelledEvent();
}

class ShowNotificationsEvent extends BaseLayoutEvent {
  const ShowNotificationsEvent();
}