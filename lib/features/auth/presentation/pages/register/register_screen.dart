import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/components/formfields/auth_form_field.dart';
import 'package:rash7ly/features/auth/bloc/auth_bloc.dart';
import 'package:rash7ly/features/auth/bloc/auth_event.dart';
import 'package:rash7ly/features/auth/bloc/auth_state.dart';
import 'package:rash7ly/features/auth/presentation/widgets/header_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();
  final namecontroller = TextEditingController();
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
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
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(Routes.mainScreen);
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
                      title: 'Sign up now',
                      subtitle: 'Please fill the details and create account',
                    ),
                    const SizedBox(height: 50),
                    registerFormFields(context, isLoading),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Form registerFormFields(BuildContext context, bool isLoading) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          AuthFormField(
            controller: namecontroller,
            hint: 'Name',
            validator: validateName,
            enabled: !isLoading,
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 50),
          MainButton(
            onPressed: () {
              if (isLoading) return;
              if (formkey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  SignUpRequested(
                    name: namecontroller.text.trim(),
                    email: emailcontroller.text.trim(),
                    password: passwordcontroller.text,
                  ),
                );
              }
            },
            text: isLoading ? 'Loading...' : 'Sign up',
            height: 65,
          ),
          const SizedBox(height: 50),
          signinText(context),
          const SizedBox(height: 60),
          iconButtons(),
        ],
      ),
    );
  }

  Row iconButtons() {
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

  Column signinText(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Already have an account?',
            style: TextStyles.getSize16(
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' Sign in',
                style: TextStyles.getSize16(
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    pushTo(context, Routes.signIn);
                  },
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Or connect',
          style: TextStyles.getSize16(
            color: AppColors.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
