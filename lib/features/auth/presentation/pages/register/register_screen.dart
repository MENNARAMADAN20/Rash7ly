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
import 'package:rash7ly/features/auth/presentation/widgets/header_text.dart';

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

  var obsecureText = false;

  @override
  Widget build(BuildContext context) {
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
                registerFormFields(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form registerFormFields(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          AuthFormField(controller: namecontroller, hint: 'Name'),
          const SizedBox(height: 20),
          AuthFormField(controller: emailcontroller, hint: 'Email'),
          const SizedBox(height: 20),
          AuthFormField(
            controller: passwordcontroller,
            obscureText: obsecureText,
            hint: 'Password',
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
          MainButton(onPressed: () {pushWithReplacement(context, Routes.home);}, text: 'Sign in', height: 65), 
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
        SvgPicture.asset(AppAssets.facebookSvg),
        const SizedBox(width: 20),
        SvgPicture.asset(AppAssets.instagramSvg),
        const SizedBox(width: 20),
        SvgPicture.asset(AppAssets.twitterSvg),
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
