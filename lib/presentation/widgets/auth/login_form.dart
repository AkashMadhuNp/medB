import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/core/utils/validators.dart';
import 'package:medb/core/service/api_service.dart';
import 'package:medb/core/model/api_error_model.dart';
import 'package:medb/presentation/auth/signup_screen.dart';
import 'package:medb/presentation/dashboard/home/home_screen.dart';
import 'package:medb/presentation/widgets/custom_elevated_buttons.dart';
import 'package:medb/presentation/widgets/custom_text_field.dart';
import 'package:medb/presentation/widgets/password_textfields.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.lato(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.lato(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(),));
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      print('Attempting login for: $email');

      final loginResponse = await _apiService.login(email, password);

      print('Login successful for user: ${loginResponse.userDetails.fullName}');

      _showSuccessSnackBar(
        'Welcome back, ${loginResponse.userDetails.firstName}!'
      );

      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (mounted) {
        _navigateToDashboard();
      }

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
      
      _showErrorSnackBar(errorMessage);
      
    } catch (e) {
      print('Unexpected error during login: $e');
      _showErrorSnackBar(
        'An unexpected error occurred. Please try again.'
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Welcome Back!",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign in to continue your healthcare journey",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Enter your email",
              prefixIcon: Icons.email_outlined,
              controller: _emailController,
              validator: Validators.validateEmail,
              keyboardType: TextInputType.emailAddress,
              
            ),
            
            const SizedBox(height: 20),
                       
            PasswordTextField(
              hintText: "Enter your password",
              controller: _passwordController,
              validator: Validators.validatePassword,
            ),

            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: _isLoading ? null : () {
                  print("Forgot password tapped");
                  // TODO: Navigate to forgot password screen
                },
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isLoading 
                        ? AppColors.primaryBlue.withOpacity(0.5)
                        : AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            CustomElevatedButton(
              text: 'Sign In',
              onPressed: _isLoading ? null : _handleLogin,
              isLoading: _isLoading,
            ),
            
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "OR",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading ? null : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isLoading 
                            ? AppColors.primaryBlue.withOpacity(0.5)
                            : AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}