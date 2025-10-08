import 'package:flutter/material.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/components/formfields/auth_form_field.dart';
import 'package:rash7ly/features/auth/presentation/widgets/header_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const HeaderText(
                  title: 'Forgot password',
                  subtitle: 'Enter your email to receive reset instructions',
                ),
                const SizedBox(height: 50),
                Form(
                  child: Column(
                    children: [
                      AuthFormField(controller: emailController, hint: 'Email'),
                      const SizedBox(height: 65),
                      MainButton(
                        onPressed: () {
                          // trigger forgot password flow
                        },
                        text: 'Reset Password',
                        height: 56,
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
