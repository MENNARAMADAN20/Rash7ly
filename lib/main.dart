import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/services/local/local_helper.dart';
import 'package:rash7ly/core/utilis/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        routerConfig: Routes.routes,
      ),
    );
  }
}
