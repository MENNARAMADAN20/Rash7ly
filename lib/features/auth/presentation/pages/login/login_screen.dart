import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/auth/presentation/widgets/auth_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();

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
                Text(
                  'sign in now',
                  style: TextStyles.getSize30(
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please sign in to continue our app',
                  style: TextStyles.getSize18(
                    fontWeight: FontWeight.w200,
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
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
                                obsecureText
                                    ? AppColors.blackColor
                                    : AppColors.greyColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //
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
                      ),
                      const SizedBox(height: 50),
                      MainButton(onPressed: () {}, text: 'Sign in', height: 65),
                      const SizedBox(height: 40),
                      RichText(
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
                                  //
                                },
                            ),
                            const TextSpan(text: ' now'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.facebookSvg),
                          const SizedBox(width: 20),
                          SvgPicture.asset(AppAssets.instagramSvg),
                          const SizedBox(width: 20),
                          SvgPicture.asset(AppAssets.twitterSvg),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
