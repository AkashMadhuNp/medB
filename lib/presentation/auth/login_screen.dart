import 'package:flutter/material.dart';
import 'package:medb/presentation/widgets/auth/login_form.dart';
import 'package:medb/presentation/widgets/gradient_scaffold.dart';
import 'package:medb/presentation/widgets/medb_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;
    
    return GradientScaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isKeyboardVisible ? 10 : 20),
                
                const MedBLogo(),
                
                SizedBox(height: isKeyboardVisible ? 15 : 30),
                
                const LoginForm(),
                
                SizedBox(height: isKeyboardVisible ? 20 : 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}