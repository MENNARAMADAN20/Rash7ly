import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rash7ly/features/Profile/presentation/profile_page/profile_screen.dart';
import 'package:rash7ly/features/auth/bloc/auth_bloc.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';
import 'package:rash7ly/features/auth/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/login/login_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/otp/otp_screen.dart';
import 'package:rash7ly/features/auth/presentation/pages/register/register_screen.dart';
import 'package:rash7ly/features/home/model/Best_destinations.dart';
import 'package:rash7ly/features/home/presentation/card_details/card_details.dart';
import 'package:rash7ly/features/categories/categories_screen.dart';
import 'package:rash7ly/features/categories/category_type_screen.dart';
import 'package:rash7ly/features/home/presentation/home/home_screen.dart';
import 'package:rash7ly/features/saved_places/savedplaces_screen.dart';
import 'package:rash7ly/features/home/presentation/search/search_screen.dart';
import 'package:rash7ly/features/main/main_screen.dart';
import 'package:rash7ly/features/onboarding/onboarding.dart';
import 'package:rash7ly/features/saved_recommendations/saved_recommendations.dart';
import 'package:rash7ly/features/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onBoard = '/onBoard';
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
  static const String savedRecommendations = '/saved_recommendations.dart';
  static const String main = '/main';

  //! by ibrahim
  static const String mainScreen = '/MainScreen';
  static const String cardDetails = '/cardDetails';

  static final routes = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: main, builder: (context, state) => MainScreen()),
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: onBoard, builder: (context, state) => OnboardingScreen()),
      GoRoute(
        path: signUp,
        builder: (context, state) => BlocProvider(
          child: RegisterScreen(),
          create: (context) =>
              AuthBloc(AuthRepository(), authRepository: AuthRepository()),
        ),
      ),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthBloc(AuthRepository(), authRepository: AuthRepository()),
          child: ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: signIn,
        builder: (context, state) => BlocProvider(
          child: LoginScreen(),
          create: (context) =>
              AuthBloc(AuthRepository(), authRepository: AuthRepository()),
        ),
      ),
      GoRoute(
        path: otp,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthBloc(AuthRepository(), authRepository: AuthRepository()),
          child: OtpScreen(),
        ),
      ),
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
      GoRoute(path: profile, builder: (context, state) => ProfileScreen()),
      //! by ibrahim
      GoRoute(path: mainScreen, builder: (context, state) => MainScreen()),
      GoRoute(
        path: cardDetails,
        builder: (context, state) {
          final card = state.extra as BestDestination;
          return CardDetails(card: card);
        },
      ),
      GoRoute(
        path: savedRecommendations,
        builder: (context, state) => SavedRecommendationsScreen(),
      ),
    ],
  );
}
