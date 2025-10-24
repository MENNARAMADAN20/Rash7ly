import 'package:go_router/go_router.dart';
import 'package:rash7ly/features/Profile/presentation/profile_page/profile_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/login/login_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/otp/otp_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/register/register_screen.dart';
import 'package:rash7ly/features/home/presentation/categories/categories_screen.dart';
import 'package:rash7ly/features/home/presentation/categories/category_type_screen.dart';
import 'package:rash7ly/features/home/presentation/home/home_screen.dart';
import 'package:rash7ly/features/home/presentation/saved_places/savedplaces_screen.dart';
import 'package:rash7ly/features/home/presentation/search/search_screen.dart';
import 'package:rash7ly/features/onboarding/onboarding.dart';


class Routes {

  static const String onBoard = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/singUp';
  static const String forgetPassword = '/forgetPassword';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String search = '/search';
  static const String categories = '/categories';
  static const String categoryType = '/categorytype';
  static const String savedplaces = '/savedplaces';
  static const String profile = '/profile_screen';

  static final routes = GoRouter(
    routes: [
      GoRoute(path: onBoard, builder: (context, state) => OnboardingScreen()),
      GoRoute(path: signUp, builder: (context, state) => RegisterScreen()),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(path: signIn, builder: (context, state) => LoginScreen()),
      GoRoute(path: otp, builder: (context, state) => OtpScreen()),
      GoRoute(path: home, builder: (context, state) => HomeScreen()),
      GoRoute(path: search, builder: (context, state) => SearchScreen()),
      GoRoute(
        path: categories,
        builder: (context, state) => CategoriesScreen(),
      ),
      GoRoute(
        path: categoryType,
        builder: (context, state) {
          final String title = state.extra.toString();
          return CategoryTypeScreen(title: title);
        },
      ),
      GoRoute(
        path: savedplaces,
        builder: (context, state) => SavedplacesScreen(),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
