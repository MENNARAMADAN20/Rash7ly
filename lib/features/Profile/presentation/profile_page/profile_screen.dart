import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/Profile/presentation/widgets/profile_field.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! this appbar by ibrahim
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 60,
        title: Text(
          "Profile",
          style: TextStyles.getSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //! this override by ibrahim
          // upperprofile(),
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
          Gap(100),
          ProfileField(
            text: "Edit profile",
            icon: Icons.person_outline_outlined,
          ),
          Gap(3),
          GestureDetector(
            onTap: () {
              pushTo(context, Routes.savedRecommendations);
            },
            child: ProfileField(
              text: "Saved Recommendations",
              icon: Icons.bookmark_border_outlined,
            ),
          ),
          Gap(3),
          ProfileField(text: "Settings", icon: Icons.settings),
          //  Divider(),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MainButton(
          text: 'Signout',
          onPressed: () {
            AuthRepository().signOut();
            pushAndRemoveUntil(context, Routes.signIn);
          },
        ),
      ),
    );
  }
}
