import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_theme.dart';
import 'package:rash7ly/features/auth/presentation/pages/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: LoginScreen(),
    );
  }
}
