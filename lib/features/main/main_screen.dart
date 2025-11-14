import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/Profile/presentation/profile_page/profile_screen.dart';
import 'package:rash7ly/features/categories/categories_screen.dart';
import 'package:rash7ly/features/home/presentation/home/home_screen.dart';
import 'package:rash7ly/features/home/presentation/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.initialPageIndex});

  final int? initialPageIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = const [
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

  void _showCreatePostSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Create New Post",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("Tap to upload image", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Write something about your post...",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.redAccent),
                      SizedBox(width: 10),
                      Text("Add your location", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: !isKeyboardOpen
          ? Transform.translate(
              offset: const Offset(5, 30),
              child: FloatingActionButton(
                onPressed: () {
                  if (currentIndex == 0) {
                    _showCreatePostSheet(context);
                  } else {

                  }
                },
                backgroundColor: AppColors.blueColor,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, size: 30, color: Colors.white),
              ),
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
