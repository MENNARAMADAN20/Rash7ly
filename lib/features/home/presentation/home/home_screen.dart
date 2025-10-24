import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/features/home/widgets/best_destination_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Gap(5),
                SvgPicture.asset(AppAssets.profilePicSvg),
                Gap(5),
                Text(
                  'Leonardo',
                  style: TextStyles.getSize12(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 15),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SvgPicture.asset(AppAssets.notificationIconSvg)],
            ),
          ),
        ],
      ),

      floatingActionButton: Transform.translate(
        offset: Offset(5, 30),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.blueColor,
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.homeIconSvg,
                    colorFilter: ColorFilter.mode(
                      AppColors.blueColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    "Home",
                    style: TextStyles.getSize12(color: AppColors.blueColor),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => pushTo(context, Routes.categories), // ibrahim edit
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.categoriesSvg,
                      colorFilter: ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      "Categories",
                      style: TextStyles.getSize12(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40),
              GestureDetector(
                onTap: () {
                  pushTo(context, Routes.search);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.searchIconSvg,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Search',
                      style: TextStyles.getSize12(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                   pushTo(context, Routes.profile);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.profileIconSvg,
                      colorFilter: ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      "Profile",
                      style: TextStyles.getSize12(color: AppColors.greyColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [SvgPicture.asset(AppAssets.homeTextSvg)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Best Destination',
                      style: TextStyles.getSize20(fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(color: AppColors.blueColor),
                    ),
                  ),
                ],
              ),
            ),
            Gap(1),
            BestDestinationListWidget(),
          ],
        ),
      ),
    );
  }
}
