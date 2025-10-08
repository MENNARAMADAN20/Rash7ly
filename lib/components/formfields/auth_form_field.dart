import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.validator,
  });

  final String hint;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }
}
