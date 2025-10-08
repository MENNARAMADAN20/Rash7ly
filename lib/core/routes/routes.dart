import 'package:go_router/go_router.dart';
import 'package:rash7ly/features/auth/presentation/pages/register/register_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onBoard1 = '/onBoard1';
  static const String onBoard2 = '/onBoard2';
  static const String onBoard3 = '/onBoard3';
  static const String signIn = '/signIn';
  static const String signUp = '/singUp';
  static const String forgetPassword = '/forgetPassword';
  static const String verification = '/verification';
  static const String home = '/home';

  static final routes = GoRouter(
    routes: [
      GoRoute(path: signUp, builder: (context, state) => RegisterScreen()),
    ],
  );
}
