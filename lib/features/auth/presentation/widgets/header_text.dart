import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        Text(
          title,
          style: TextStyles.getSize30(
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: TextStyles.getSize18(
            fontWeight: FontWeight.w200,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
