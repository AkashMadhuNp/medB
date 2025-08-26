import 'package:flutter/material.dart';
import 'package:medb/core/theme/themes.dart';
import 'package:medb/presentation/auth/login_screen.dart';
import 'package:medb/presentation/dashboard/home/home_screen.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MedB",
      theme: AppTheme.lightTheme,
      home:HomeScreen() ,

    );
  }
}