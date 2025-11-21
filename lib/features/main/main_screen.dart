import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/Profile/presentation/profile_page/profile_screen.dart';
import 'package:rash7ly/features/categories/categories_screen.dart';
import 'package:rash7ly/features/home/presentation/home/home_screen.dart';
import 'package:rash7ly/features/home/presentation/search/search_screen.dart';
import 'package:rash7ly/features/add_new_recommendation/Presentation/Widgets/add_new_rec.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.initialPageIndex});

  final int? initialPageIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages =  [
    HomeScreen(),
    CategoriesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialPageIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: !isKeyboardOpen
          ? Transform.translate(
              offset: const Offset(5, 30),
              child: AddNewRec(currentIndex: currentIndex),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(AppAssets.homeIconSvg, "Home", 0),
              _buildNavItem(AppAssets.categoriesSvg, "Categories", 1),
              const SizedBox(width: 40),
              _buildNavItem(AppAssets.searchIconSvg, "Search", 2),
              _buildNavItem(AppAssets.profileIconSvg, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    final bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive ? AppColors.blueColor : AppColors.greyColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyles.getSize12(
              color: isActive ? AppColors.blueColor : AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
