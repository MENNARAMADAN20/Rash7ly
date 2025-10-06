import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.width = double.infinity,
    this.height = 56,
    required this.onPressed,
  });
  final String text;
  final double width;
  final double height;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyles.getSize16(color: Colors.white)),
      ),
    );
  }
}
