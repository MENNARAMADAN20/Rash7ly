import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/presentation/widgets/_build_icon.dart';

class upperprofile extends StatelessWidget {
  const upperprofile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                //   Navigator.pop(context);
              },
              icon: buildicon(
                icon: Icons.arrow_back_ios_new_outlined,
                color: const Color.fromARGB(255, 243, 243, 243),
                iconcolor: AppColors.blackColor,
              ),
              // icon: _build_icon(Icons.arrow_back_ios_new_rounded),
            ),
            Text(
              'Profile',
              style: TextStyles.getSize18(
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: buildicon(
                icon: Icons.edit_rounded,
                color: const Color.fromARGB(255, 243, 243, 243),
                iconcolor: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
