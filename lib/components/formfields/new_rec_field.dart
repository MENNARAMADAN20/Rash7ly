import 'package:flutter/material.dart';

class NewRecField extends StatelessWidget {
   NewRecField({
    super.key,
    this.selectedCategory,
    this.text,
    this.maxLines,
    this.validator,
    required this.controller,
  });
  final String? selectedCategory;
  final String? text;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: text ?? '',
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
