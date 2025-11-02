import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/presentation/widgets/_build_icon.dart';
import 'package:rash7ly/features/home/widgets/arrow_back_app_bar.dart';

class UpperCard extends StatelessWidget {
  const UpperCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           ArrowBackAppBar(
            backgroundColor: const Color.fromARGB(96, 18, 19, 23),
            iconColor: AppColors.whiteColor,
           ),
            Text(
              'Details',
              style: TextStyles.getSize18(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: buildicon(icon: Icons.bookmark_border),
            ),
          ],
        ),
      ),
    );
  }
}
