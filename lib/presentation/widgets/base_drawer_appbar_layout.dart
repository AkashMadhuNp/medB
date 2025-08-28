import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/presentation/BLoC/baselayout/bloc/baselayout_bloc.dart';
import 'package:medb/presentation/BLoC/baselayout/bloc/baselayout_event.dart';
import 'package:medb/presentation/BLoC/baselayout/bloc/baselayout_state.dart';
import 'package:medb/presentation/auth/login_screen.dart';
import 'package:medb/presentation/dashboard/profile/pofile_screen.dart';
import 'package:medb/presentation/widgets/dynamic_drawer.dart';

class BaseLayout extends StatelessWidget {
  final String currentScreen;
  final Widget body;
  final String? title;

  const BaseLayout({
    super.key,
    required this.currentScreen,
    required this.body,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BaseLayoutBloc, BaseLayoutState>(
      listener: (context, state) {
        _handleStateChanges(context, state);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "assets/m_logo.png", 
            height: 50, 
            width: 50, 
            fit: BoxFit.cover
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          actions: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey,
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  context.read<BaseLayoutBloc>().add(
                    const ShowNotificationsEvent()
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 20),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: BlocBuilder<BaseLayoutBloc, BaseLayoutState>(
                builder: (context, state) {
                  return IconButton(
                    icon: state is LogoutLoadingState
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 172, 174, 179),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.exit_to_app,
                            size: 30,
                            color: Color.fromARGB(255, 172, 174, 179),
                          ),
                    onPressed: state is LogoutLoadingState
                        ? null
                        : () {
                            context.read<BaseLayoutBloc>().add(
                              const LogoutRequestedEvent()
                            );
                          },
                    tooltip: 'Exit',
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: DynamicDrawer(
          currentScreen: currentScreen,
          onMenuTap: (route, screenName) {
            Navigator.of(context).pop();
            
            if (currentScreen == screenName) {
              return;
            }
            
            Future.delayed(const Duration(milliseconds: 200), () {
              context.read<BaseLayoutBloc>().add(
                NavigateToScreenEvent(
                  screenName: screenName,
                  route: route,
                ),
              );
            });
          },
        ),
        body: body,
      ),
    );
  }

  void _handleStateChanges(BuildContext context, BaseLayoutState state) {
    switch (state.runtimeType) {
      case NavigationState:
        final navState = state as NavigationState;
        if (navState.targetScreen != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => navState.targetScreen!,
            ),
          );
        }
        break;
        
      case ComingSoonState:
        final comingSoonState = state as ComingSoonState;
        _showComingSoonSnackBar(context, comingSoonState.screenName);
        break;
        
      case LogoutDialogState:
        _showLogoutDialog(context);
        break;
        
      case LogoutSuccessState:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        break;
        
      case LogoutErrorState:
        final errorState = state as LogoutErrorState;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${errorState.error}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
        
      case NotificationState:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notifications - Coming Soon!'),
            backgroundColor: AppColors.lblu,
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
    }
  }

  void _showComingSoonSnackBar(BuildContext context, String screenName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$screenName - Coming Soon!'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.lblu,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  
  
 void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Center(
          child: Text(
            'Logout',
            style: Theme.of(context).textTheme.titleLarge
          ),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      context.read<BaseLayoutBloc>().add(
                        const LogoutCancelledEvent(),
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: AppColors.surface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BlocBuilder<BaseLayoutBloc, BaseLayoutState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: state is LogoutLoadingState
                            ? null
                            : () {
                                Navigator.of(dialogContext).pop();
                                context.read<BaseLayoutBloc>().add(
                                  const LogoutConfirmedEvent(),
                                );
                              },
                        child: state is LogoutLoadingState
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Yes, Logout',
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: AppColors.surface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}}