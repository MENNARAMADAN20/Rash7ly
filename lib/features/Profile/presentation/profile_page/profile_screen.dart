import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/Profile/presentation/widgets/profile_field.dart';
import 'package:rash7ly/features/Profile/presentation/widgets/upperprofile.dart';
import 'package:rash7ly/features/home/presentation/widgets/_build_icon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          upperprofile(),
          Image.asset(AppAssets.personProfile),
          Text(
            'Leonardo',
            style: TextStyles.getSize24(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
          Text(
            'Leonardo@gmail.com',
            style: TextStyles.getSize18(
              fontWeight: FontWeight.normal,
              color: AppColors.greyColor,
            ),
          ),
          Gap(30),
         
         ProfileField(text: "profile", icon: Icons.person_outline_outlined),
          ProfileField(
            text: "Saved Recommendations",
            icon: Icons.bookmark_border_outlined,
          ),
          ProfileField(text: "Settings", icon: Icons.settings),
          //  Divider(),
        ],
      ),
    );
  }
}
