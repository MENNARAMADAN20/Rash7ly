import 'package:go_router/go_router.dart';
import 'package:rash7ly/features/auth/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/login/login_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/otp/otp_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/register/register_screen.dart';
import 'package:rash7ly/features/home/presentation/home/home_screen.dart';
import 'package:rash7ly/features/home/presentation/search/search_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onBoard1 = '/onBoard1';
  static const String onBoard2 = '/onBoard2';
  static const String onBoard3 = '/onBoard3';
  static const String signIn = '/signIn';
  static const String signUp = '/singUp';
  static const String forgetPassword = '/forgetPassword';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String search = '/search';

  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const LoginScreen()),
      GoRoute(path: signUp, builder: (context, state) => RegisterScreen()),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(path: signIn, builder: (context, state) => LoginScreen()),
      GoRoute(path: otp, builder: (context, state) => OtpScreen()),
      GoRoute(path: home, builder: (context, state) => HomeScreen()),
      GoRoute(path: search, builder: (context, state) => SearchScreen()),
    ],
  );
}
