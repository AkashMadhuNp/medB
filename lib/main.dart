import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medb/core/service/auth_service.dart';
import 'package:medb/core/service/api_service.dart';
import 'package:medb/core/theme/themes.dart';
import 'package:medb/presentation/BLoC/baselayout/bloc/baselayout_bloc.dart';
import 'package:medb/presentation/BLoC/login/bloc/login_bloc.dart';
import 'package:medb/presentation/BLoC/signup/bloc/signup_bloc.dart';
import 'package:medb/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await AuthService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<BaseLayoutBloc>(
          create: (context) => BaseLayoutBloc(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MedB",
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}