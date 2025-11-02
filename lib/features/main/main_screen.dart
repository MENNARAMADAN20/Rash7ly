import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/features/Profile/presentation/profile_page/profile_screen.dart';
import 'package:rash7ly/features/home/presentation/categories/categories_screen.dart';
import 'package:rash7ly/features/home/presentation/home/home_screen.dart';
import 'package:rash7ly/features/home/presentation/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.initialPageIndex});

  final int? initialPageIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    HomeScreen(),
    CategoriesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initialPageIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: Transform.translate(
        offset: Offset(5, 30),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildNavItem(AppAssets.homeIconSvg, "Home", 0),
            BuildNavItem(AppAssets.categoriesSvg, "Categories", 1),
            const SizedBox(width: 40),
            BuildNavItem(AppAssets.searchIconSvg, "Search", 2),
            BuildNavItem(AppAssets.profileIconSvg, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget BuildNavItem(String icon, String label, int index) {
    final isActive = currentIndex == index;
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
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive ? Colors.blue : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
