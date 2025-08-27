import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medb/core/model/user_model.dart';
import 'package:medb/core/utils/validators.dart';
import 'package:medb/presentation/BLoC/signup/bloc/signup_bloc.dart';
import 'package:medb/presentation/BLoC/signup/bloc/signup_event.dart';
import 'package:medb/presentation/BLoC/signup/bloc/signup_state.dart';
import 'package:medb/presentation/auth/login_screen.dart';
import 'package:medb/presentation/widgets/custom_elevated_buttons.dart';
import 'package:medb/presentation/widgets/custom_text_field.dart';
import 'package:medb/presentation/widgets/password_textfields.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        firstName: _firstNameController.text.trim(),
        middleName: _middleNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        contactNo: _phoneController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      context.read<SignUpBloc>().add(SignUpSubmitted(user: user));
    }
  }

  void _clearForm() {
    _emailController.clear();
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    
    // Reset form validation state
    _formKey.currentState?.reset();
  }

  void _navigateToLogin() {
    // Clear form data before navigation
    _clearForm();
    
    // Reset BLoC state
    context.read<SignUpBloc>().add(SignUpFormReset());
    
    // Navigate to login screen and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false, // This removes all previous routes
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxFormWidth = screenWidth > 600 ? 400.0 : double.infinity;
    final isSmallScreen = screenWidth < 400;

    return Center(
      child: Container(
        width: maxFormWidth,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 400 ? 20.0 : 10.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6F64E7).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) {
                  _navigateToLogin();
                }
              });
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildFirstNameField(),
                  const SizedBox(height: 20),
                  _buildNameFields(isSmallScreen),
                  const SizedBox(height: 20),
                  _buildPhoneField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 20),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 30),
                  
                  // Loading indicator and error message
                  if (state is SignUpLoading) ...[
                    const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF6F64E7),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Creating your account...',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  if (state is SignUpFailure) ...[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.errorMessage,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  _CustomSignUpButton(),
                  const SizedBox(height: 24),
                  _buildSignInLink(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Create Account",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6F64E7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Join us for better healthcare",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      hintText: "Enter your email",
      prefixIcon: Icons.email_outlined,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: Validators.validateEmail,
    );
  }

  Widget _buildFirstNameField() {
    return CustomTextField(
      hintText: "Enter your first name",
      prefixIcon: Icons.person_outline,
      controller: _firstNameController,
      keyboardType: TextInputType.name,
      validator: Validators.validateRequiredField,
    );
  }

  Widget _buildNameFields(bool isSmallScreen) {
    if (isSmallScreen) {
      return Column(
        children: [
          CustomTextField(
            hintText: "Enter middle name (optional)",
            prefixIcon: Icons.person_outline,
            controller: _middleNameController,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: "Enter your last name",
            prefixIcon: Icons.person_outline,
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            validator: Validators.validateRequiredField,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CustomTextField(
            hintText: "Middle Name (optional)",
            prefixIcon: Icons.person_outline,
            controller: _middleNameController,
            keyboardType: TextInputType.name,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: CustomTextField(
            hintText: "Last Name",
            prefixIcon: Icons.person_outline,
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            validator: Validators.validateRequiredField,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return CustomTextField(
      hintText: "Enter phone number",
      prefixIcon: Icons.call,
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      validator: Validators.validatePhone,
    );
  }

  Widget _buildPasswordField() {
    return PasswordTextField(
      hintText: "Enter your password",
      controller: _passwordController,
      validator: Validators.validatePassword,
    );
  }

  Widget _buildConfirmPasswordField() {
    return PasswordTextField(
      hintText: "Confirm your password",
      controller: _confirmPasswordController,
      validator: _validateConfirmPassword,
    );
  }


  Widget _CustomSignUpButton(){
    return CustomElevatedButton(
      text: "Create Account",
      onPressed:_handleSignUp ,
      );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
          ),
          GestureDetector(
            onTap: () {
              _clearForm();
              Navigator.pop(context);
            },
            child: Text(
              "Sign In",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6F64E7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}