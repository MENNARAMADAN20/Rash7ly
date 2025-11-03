import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/widgets/home_list_widget.dart';
import 'package:rash7ly/features/home/widgets/home_text_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    double offset = _scrollController.offset;
    setState(() {
      _appBarOpacity = (1 - offset / 100).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                const Gap(20),
                Center(
                  child: Text(
                    "Create New Post",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blueColor,
                    ),
                  ),
                ),
                const Gap(25),

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
                        Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Gap(10),
                        Text(
                          "Tap to upload image",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(20),

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

                const Gap(20),

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
                      Gap(10),
                      Text(
                        "Add your location",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const Gap(30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor,
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

  Widget _animatedCardWrapper(Widget child, int index) {
    if (index == 0) return child;
    double startOffset = 100.0 * (index - 1);
    double scroll = _scrollController.hasClients ? _scrollController.offset : 0;
    double opacity = ((scroll - startOffset) / 100).clamp(0.0, 1.0);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(0, 50 * (1 - opacity)),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [SvgPicture.asset(AppAssets.homeTextSvg)],
                    ),
                  ),
                  HomeTextRow(RowText: 'Best Destination'),
                  HomeListWidget(),
                  const Gap(20),
                  _animatedCardWrapper(
                    HomeTextRow(RowText: 'Saved Recommendations'),
                    0,
                  ),
                  _animatedCardWrapper(HomeListWidget(), 2),
                  const Gap(10),
                  _animatedCardWrapper(
                    HomeTextRow(RowText: 'Popular Package'),
                    4,
                  ),
                  _animatedCardWrapper(HomeListWidget(), 2),
                ],
              ),
            ),

            Opacity(
              opacity: _appBarOpacity,
              child: Container(
                height: 80,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.profilePicSvg),
                          const Gap(5),
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
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: SvgPicture.asset(AppAssets.notificationIconSvg),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      

      
    );
  }
}
