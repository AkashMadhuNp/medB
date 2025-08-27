import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:medb/core/service/auth_service.dart';
import 'package:medb/core/service/api_service.dart';
import 'package:medb/presentation/BLoC/baselayout/bloc/baselayout_event.dart';
import 'package:medb/presentation/BLoC/baselayout/bloc/baselayout_state.dart';
import 'package:medb/presentation/dashboard/appoinment/appoinment_screen.dart';
import 'package:medb/presentation/dashboard/healthrecord/health_screen.dart';
import 'package:medb/presentation/dashboard/home/home_screen.dart';
import 'package:medb/presentation/dashboard/profile/pofile_screen.dart';

class BaseLayoutBloc extends Bloc<BaseLayoutEvent, BaseLayoutState> {
  final ApiService _apiService;

  BaseLayoutBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(const BaseLayoutInitial()) {
    on<NavigateToScreenEvent>(_onNavigateToScreen);
    on<LogoutRequestedEvent>(_onLogoutRequested);
    on<LogoutConfirmedEvent>(_onLogoutConfirmed);
    on<LogoutCancelledEvent>(_onLogoutCancelled); 
    on<ShowNotificationsEvent>(_onShowNotifications);
  }

  void _onNavigateToScreen(
    NavigateToScreenEvent event,
    Emitter<BaseLayoutState> emit,
  ) {
    final targetScreen = _getScreenForMenuName(event.screenName);
    
    if (targetScreen != null) {
      emit(NavigationState(
        targetScreen: targetScreen,
        screenName: event.screenName,
      ));
    } else {
      emit(ComingSoonState(screenName: event.screenName));
    }
  }

  void _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<BaseLayoutState> emit,
  ) {
    emit(const LogoutDialogState());
  }

  void _onLogoutCancelled(
    LogoutCancelledEvent event,
    Emitter<BaseLayoutState> emit,
  ) {
    emit(const BaseLayoutInitial()); 
  }

  Future<void> _onLogoutConfirmed(
    LogoutConfirmedEvent event,
    Emitter<BaseLayoutState> emit,
  ) async {
    emit(const LogoutLoadingState());
    
    try {
      // print('Before logout - Access Token: ${AuthService.accessToken != null ? "EXISTS" : "NULL"}');
      // print('Before logout - User Details: ${AuthService.userDetails != null ? "EXISTS" : "NULL"}');
      // print('Before logout - Menu Data: ${AuthService.hasMenuData ? "EXISTS" : "NULL"}');
      // print('Before logout - Is Logged In: ${AuthService.isLoggedIn}');
      
      // await _apiService.logout();
      
      // print('After logout - Access Token: ${AuthService.accessToken != null ? "EXISTS" : "NULL"}');
      // print('After logout - User Details: ${AuthService.userDetails != null ? "EXISTS" : "NULL"}');
      // print('After logout - Menu Data: ${AuthService.hasMenuData ? "EXISTS" : "NULL"}');
      // print('After logout - Is Logged In: ${AuthService.isLoggedIn}');
      
      emit(const LogoutSuccessState());
    } catch (e) {
      print('Logout error: $e');
      emit(LogoutErrorState(error: e.toString()));
    }
  }

  void _onShowNotifications(
    ShowNotificationsEvent event,
    Emitter<BaseLayoutState> emit,
  ) {
    emit(const NotificationState());
  }

  Widget? _getScreenForMenuName(String menuName) {
    switch (menuName) {
      case 'Appointments':
        return AppointmentsScreen();
      
      case 'Health Records':
        return HealthRecordsScreen();
      
      case 'Home':
        return HomeScreen();
      
      case 'Profile':
        return const ProfileScreen();
      
      default:
        final menuItem = AuthService.findMenuByName(menuName);
        final controllerName = menuItem?.controllerName;
        
        if (controllerName == null) return null;
        
        if (controllerName.contains('appointment')) {
          return AppointmentsScreen();
        } else if (controllerName.contains('health')) {
          return HealthRecordsScreen();
        } else if (controllerName.contains('profile') || controllerName.contains('account')) {
          return const ProfileScreen();
        } else if (controllerName.contains('dashboard') || controllerName.contains('home')) {
          return HomeScreen();
        }
        return null;
    }
  }
}