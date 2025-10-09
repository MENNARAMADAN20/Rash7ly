import 'package:flutter/material.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/components/formfields/auth_form_field.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
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
        leading: ArrowBackAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 50),
              HeaderText(
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
                        pushTo(context, Routes.otp);
                      },
                      text: 'Reset Password',
                      height: 65,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
