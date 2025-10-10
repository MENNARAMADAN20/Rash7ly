import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class HeaderText extends StatelessWidget {
  HeaderText({
    super.key,
    required this.title,
    required this.subtitle,
    this.style,
  });

  final String title;
  final String subtitle;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style:
              style ??
              TextStyles.getSize30(
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style:
              style ??
              TextStyles.getSize18(
                fontWeight: FontWeight.w200,
                color: AppColors.greyColor,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
