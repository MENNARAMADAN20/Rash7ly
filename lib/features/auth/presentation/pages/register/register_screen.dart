import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
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
                HeaderText(
                  title: 'sign up now',
                  subtitle: 'Please fill the details and create account',
                ),
                const SizedBox(height: 50),
                Form(
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
                                obsecureText
                                    ? AppColors.blackColor
                                    : AppColors.greyColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      MainButton(onPressed: () {}, text: 'Sign in', height: 65),
                      const SizedBox(height: 50),
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
                                  //
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
