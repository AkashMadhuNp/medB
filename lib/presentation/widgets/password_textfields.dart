import 'package:flutter/material.dart';
import 'package:medb/presentation/widgets/custom_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PasswordTextField({
    super.key,
    this.hintText = "Password",
    this.controller,
    this.validator,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hintText,
      prefixIcon: Icons.lock_outline,
      obscureText: _isObscured,
      controller: widget.controller,
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: Colors.grey,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}