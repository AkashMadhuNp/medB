import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/core/service/auth_service.dart';
import 'package:medb/presentation/auth/login_screen.dart';
import 'package:medb/presentation/dashboard/home/home_screen.dart';
import 'package:medb/presentation/widgets/gradient_scaffold.dart';
import 'dart:ui';

import 'package:medb/presentation/widgets/loading_overlay.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _isCheckingAuth = false;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
    
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isCheckingAuth = true;
    });
    
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;

    try {
      bool isLoggedIn = AuthService.isLoggedIn;
      
      if (isLoggedIn) {
        print('User is logged in, navigating to home screen');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(), 
          ),
        );
      } else {
        print('User not logged in, navigating to login screen');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      print('Error checking auth status: $e');
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isCheckingAuth,
      
      child: GradientScaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset("assets/m_logo.png", height: 50,)
                      ),
                      const SizedBox(height: 30),
                      
                      Image.asset(
                        "assets/medb_logo.png",
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(height: 10,),
                      
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 14, 
                            fontWeight: FontWeight.w500,
                            height: 1.2, 
                          ),
                          children: [
                            TextSpan(
                              text: "Bringing ",
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: "Healthcare",
                              style: GoogleFonts.poppins(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " to your finger tips",
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      
                      if (!_isCheckingAuth)
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

