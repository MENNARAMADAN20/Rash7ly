import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/auth/data/models/user_model.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/widgets/home_list_widget.dart';
import 'package:rash7ly/features/home/widgets/home_text_row.dart';
import 'package:shimmer/shimmer.dart';

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
          // <<<<<<< HEAD
          //         ),
          //         actions: [
          //           //! this gesturedetector by ibrahim
          //           GestureDetector(
          //             // push to notification screen
          //             // onTap: () => pushTo(context, route),
          //             child: Container(
          //               margin: const EdgeInsets.only(top: 10, right: 15),
          //               width: 44,
          //               height: 44,
          //               decoration: BoxDecoration(
          //                 color: AppColors.lightGreyColor,
          //                 borderRadius: BorderRadius.circular(50),
          //               ),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [SvgPicture.asset(AppAssets.notificationIconSvg)],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       //! this override by ibrahim
          //       // floatingActionButton: Transform.translate(
          //       //   offset: Offset(5, 30),
          //       //   child: FloatingActionButton(
          //       //     onPressed: () {},
          //       //     backgroundColor: AppColors.blueColor,
          //       //     shape: CircleBorder(),
          //       //     child: Icon(Icons.add, size: 30, color: Colors.white),
          //       //   ),
          //       // ),
          //       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          //       // bottomNavigationBar: BottomAppBar(
          //       //   color: AppColors.whiteColor,
          //       //   child: SizedBox(
          //       //     height: 70,
          //       //     child: Row(
          //       //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       //       children: [
          //       //         Column(
          //       //           mainAxisAlignment: MainAxisAlignment.center,
          //       //           children: [
          //       //             SvgPicture.asset(
          //       //               AppAssets.homeIconSvg,
          //       //               colorFilter: ColorFilter.mode(
          //       //                 AppColors.blueColor,
          //       //                 BlendMode.srcIn,
          //       //               ),
          //       //             ),
          //       //             Text(
          //       //               "Home",
          //       //               style: TextStyles.getSize12(color: AppColors.blueColor),
          //       //             ),
          //       //           ],
          //       //         ),
          //       //         GestureDetector(
          //       //           onTap: () => pushTo(context, Routes.categories), // ibrahim edit
          //       //           child: Column(
          //       //             mainAxisAlignment: MainAxisAlignment.center,
          //       //             children: [
          //       //               SvgPicture.asset(
          //       //                 AppAssets.categoriesSvg,
          //       //                 colorFilter: ColorFilter.mode(
          //       //                   AppColors.greyColor,
          //       //                   BlendMode.srcIn,
          //       //                 ),
          //       //               ),
          //       //               Text(
          //       //                 "Categories",
          //       //                 style: TextStyles.getSize12(color: AppColors.greyColor),
          //       //               ),
          //       //             ],
          //       //           ),
          //       //         ),
          //       //         SizedBox(width: 40),
          //       //         GestureDetector(
          //       //           onTap: () {
          //       //             pushTo(context, Routes.search);
          //       //           },
          //       //           child: Column(
          //       //             mainAxisSize: MainAxisSize.min,
          //       //             children: [
          //       //               SvgPicture.asset(
          //       //                 AppAssets.searchIconSvg,
          //       //                 height: 24,
          //       //                 colorFilter: ColorFilter.mode(
          //       //                   AppColors.greyColor,
          //       //                   BlendMode.srcIn,
          //       //                 ),
          //       //               ),
          //       //               SizedBox(height: 4),
          //       //               Text(
          //       //                 'Search',
          //       //                 style: TextStyles.getSize12(color: AppColors.greyColor),
          //       //               ),
          //       //             ],
          //       //           ),
          //       //         ),
          //       //         GestureDetector(
          //       //           onTap: () {
          //       //              pushTo(context, Routes.profile);
          //       //           },
          //       //           child: Column(
          //       //             mainAxisAlignment: MainAxisAlignment.center,
          //       //             children: [
          //       //               SvgPicture.asset(
          //       //                 AppAssets.profileIconSvg,
          //       //                 colorFilter: ColorFilter.mode(
          //       //                   AppColors.greyColor,
          //       //                   BlendMode.srcIn,
          //       //                 ),
          //       //               ),
          //       //               Text(
          //       //                 "Profile",
          //       //                 style: TextStyles.getSize12(color: AppColors.greyColor),
          //       //               ),
          //       //             ],
          //       //           ),
          //       //         ),
          //       //       ],
          //       //     ),
          //       //   ),
          //       // ),
          //       body: SingleChildScrollView(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.all(20),
          //               child: Column(
          //                 children: [SvgPicture.asset(AppAssets.homeTextSvg)],
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 20),
          //               child: Row(
          //                 children: [
          //                   Expanded(
          //                     child: Text(
          //                       'Best Destination',
          //                       style: TextStyles.getSize20(fontWeight: FontWeight.w600),
          //                     ),
          //                   ),
          //                   TextButton(
          //                     onPressed: () {},
          //                     child: Text(
          //                       'View all',
          //                       style: TextStyle(color: AppColors.blueColor),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Gap(1),
          //             BestDestinationListWidget(),
          //           ],
          //         ),
          // =======
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
        // >>>>>>> cdc2b05c0d612756d20dad6ed50b5c8db2cc4c34
      ),
    );
  }

  //! vars by ibarahim
  bool isLoading = true;
  late UserModel user;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HomeBloc>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GetUserLoadingState) {
            isLoading = true;
          } else if (state is GetUserSuccessState) {
            isLoading = false;
            user = state.userModel!;
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                          // width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.lightGreyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              if (isLoading == false) ...{
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.profilePicSvg,
                                  ),
                                ),
                                // SvgPicture.asset(
                                //   AppAssets.profilePicSvg,
                                // ),
                                const Gap(10),
                                Text(
                                  user.name,
                                  style: TextStyles.getSize12(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              } else ...{
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // const Gap(10),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 18,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              },
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
                            child: SvgPicture.asset(
                              AppAssets.notificationIconSvg,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
