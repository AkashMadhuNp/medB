import 'package:flutter/material.dart';
import 'package:medb/core/model/api_error_model.dart';
import 'package:medb/core/model/user_model.dart';
import 'package:medb/core/service/api_service.dart';
import 'package:medb/core/utils/validators.dart';
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

  bool _isLoading = false;
  String? _errorMessage;

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

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final user = UserModel(
          firstName: _firstNameController.text.trim(),
          middleName: _middleNameController.text.trim(), // Added
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          contactNo: _phoneController.text.trim(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );

        final apiService = ApiService();
        final message = await apiService.register(user);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$message Please verify your email before logging in'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
        }
      } on ApiError catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = e.message;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = 'An unexpected error occurred';
          });
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
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
        child: Form(
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
              const SizedBox(height: 20),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
              if (_errorMessage != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              _buildSignUpButton(),
              const SizedBox(height: 24),
              _buildSignInLink(context),
            ],
          ),
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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "Join us for better healthcare",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
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

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignUp, 
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6F64E7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
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
            onTap: () => Navigator.pop(context),
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