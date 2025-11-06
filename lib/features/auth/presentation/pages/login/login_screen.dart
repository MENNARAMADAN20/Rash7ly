import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/components/formfields/auth_form_field.dart';
import 'package:rash7ly/features/auth/presentation/widgets/header_text.dart';
import 'package:rash7ly/features/auth/bloc/auth_bloc.dart';
import 'package:rash7ly/features/auth/bloc/auth_event.dart';
import 'package:rash7ly/features/auth/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  var obsecureText = true;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          pushAndRemoveUntil(context, Routes.mainScreen);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    HeaderText(
                      title: 'Sign in',
                      subtitle: 'Please sign in to continue',
                    ),
                    const SizedBox(height: 50),
                    loginFormFields(context, isLoading),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Form loginFormFields(BuildContext context, bool isLoading) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          AuthFormField(
            controller: emailcontroller,
            hint: 'Email',
            validator: validateEmail,
            enabled: !isLoading,
          ),
          const SizedBox(height: 20),
          AuthFormField(
            controller: passwordcontroller,
            obscureText: obsecureText,
            hint: 'Password',
            validator: validatePassword,
            enabled: !isLoading,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
              child: Transform.scale(
                scale: 0.5,
                child: SvgPicture.asset(
                  AppAssets.passwordEye,
                  colorFilter: ColorFilter.mode(
                    obsecureText ? AppColors.blackColor : AppColors.greyColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          forgotPasswordButton(context),
          const SizedBox(height: 50),
          MainButton(
            onPressed: () {
              if (isLoading) return;
              if (formkey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  SignInRequested(
                    email: emailcontroller.text.trim(),
                    password: passwordcontroller.text,
                  ),
                );
              }
            },
            text: isLoading ? 'Loading...' : 'Sign in',
            height: 65,
          ),
          const SizedBox(height: 40),
          signUpButton(context),
          const SizedBox(height: 60),
          iconsButtons(),
        ],
      ),
    );
  }

  Row iconsButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(SignInWithFacebookEvent());
          },
          child: SvgPicture.asset(AppAssets.facebookSvg),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(SignInWithGoogleEvent());
          },
          child: SvgPicture.asset(AppAssets.google),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(SignInWithTwitterEvent());
          },
          child: SvgPicture.asset(AppAssets.twitterSvg),
        ),
      ],
    );
  }

  RichText signUpButton(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account?',
        style: TextStyles.getSize16(
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: ' Sign up',
            style: TextStyles.getSize16(
              color: AppColors.blueColor,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                pushTo(context, Routes.signUp);
              },
          ),
          const TextSpan(text: ' now'),
        ],
      ),
    );
  }

  Row forgotPasswordButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            pushTo(context, Routes.forgetPassword);
          },
          child: Text(
            'Forgot password?',
            style: TextStyles.getSize16(
              fontWeight: FontWeight.w500,
              color: AppColors.blueColor,
            ),
          ),
        ),
      ],
    );
  }
}
