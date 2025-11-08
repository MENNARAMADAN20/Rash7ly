import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/components/formfields/auth_form_field.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/features/auth/bloc/auth_bloc.dart';
import 'package:rash7ly/features/auth/bloc/auth_event.dart';
import 'package:rash7ly/features/auth/bloc/auth_state.dart';
import 'package:rash7ly/features/auth/presentation/widgets/header_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ArrowBackAppBar(),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetEmailSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset email sent')),
            );
            pushTo(context, Routes.signIn);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        child: SingleChildScrollView(
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
                  key: formKey,
                  child: Column(
                    children: [
                      AuthFormField(
                        controller: emailController,
                        hint: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Simple email validation
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 65),
                      MainButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            context.read<AuthBloc>().add(
                              SendPasswordResetEmailEvent(emailController.text),
                            );
                          }
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
      ),
    );
  }
}
