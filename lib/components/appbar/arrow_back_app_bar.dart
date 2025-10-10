import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';

class ArrowBackAppBar extends StatelessWidget {
  const ArrowBackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      padding: const EdgeInsets.fromLTRB(7, 0, 0, 5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightGreyColor,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
