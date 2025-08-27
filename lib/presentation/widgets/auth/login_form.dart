import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medb/presentation/BLoC/login/bloc/login_bloc.dart';
import 'package:medb/presentation/BLoC/login/bloc/login_event.dart';
import 'package:medb/presentation/BLoC/login/bloc/login_state.dart';
import 'package:medb/presentation/widgets/auth/divider.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/core/utils/validators.dart';
import 'package:medb/presentation/auth/signup_screen.dart';
import 'package:medb/presentation/dashboard/home/home_screen.dart';
import 'package:medb/presentation/widgets/auth_header.dart';
import 'package:medb/presentation/widgets/custom_elevated_buttons.dart';
import 'package:medb/presentation/widgets/custom_text_field.dart';
import 'package:medb/presentation/widgets/loading_overlay.dart';
import 'package:medb/presentation/widgets/password_textfields.dart';
import 'package:medb/presentation/widgets/forgot_password_link.dart';
import 'package:medb/presentation/widgets/shimmer_text_field.dart';
import 'package:medb/presentation/widgets/sign_up_link.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  bool _isNavigating = false; 

  @override
  void initState() {
    super.initState();
    _clearForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.add(LoginReset());
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.add(LoginReset());
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.lblu,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToDashboard() {
    setState(() {
      _isNavigating = true; 
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _loginBloc.add(LoginSubmitted(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _showSuccessSnackBar(state.message);
          _navigateToDashboard();
        } else if (state is LoginFailure) {
          _showErrorSnackBar(state.errorMessage);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return LoadingOverlay(
            isLoading: _isNavigating, 
            loadingText: "Redirecting to Dashboard...", 
            child: Container(
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
                    AuthHeader(
                      title: 'Welcome Back!',
                      subtitle: 'Sign in to continue your healthcare journey',
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 32),
                    if (isLoading)
                      const ShimmerTextField()
                    else
                      CustomTextField(
                        hintText: 'Enter your email',
                        prefixIcon: Icons.email_outlined,
                        controller: _emailController,
                        validator: Validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    const SizedBox(height: 20),
                    if (isLoading)
                      const ShimmerTextField()
                    else
                      PasswordTextField(
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        validator: Validators.validatePassword,
                      ),
                    const SizedBox(height: 8),
                    ForgotPasswordLink(
                      isLoading: isLoading,
                      onTap: () {
                        print('Forgot password tapped');
                      },
                    ),
                    const SizedBox(height: 32),
                    CustomElevatedButton(
                      text: 'Sign In',
                      onPressed: isLoading ? null : _handleLogin,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 24),
                    OrDivider(isLoading: isLoading),
                    const SizedBox(height: 24),
                    SignUpLink(
                      isLoading: isLoading,
                      onTap: () {
                        _clearForm();
                        _loginBloc.add(LoginReset());
                        ScaffoldMessenger.of(context).clearSnackBars();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}