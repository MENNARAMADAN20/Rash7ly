import 'package:flutter/material.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: Routes.routes,
    );
  }
}
