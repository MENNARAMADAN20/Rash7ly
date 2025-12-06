import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/services/local/local_helper.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/data/repo/home_repo.dart';
import 'package:rash7ly/features/home/widgets/home_list_widget.dart';
import 'package:rash7ly/features/home/widgets/home_text_row.dart';
import 'package:rash7ly/features/home/widgets/impty_widget.dart';
import 'package:rash7ly/features/home/widgets/saved_recommendation_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 1.0;
  var user = LocalHelper.getUserData();

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

  bool isloading = true;
  bool isimpty = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(authRepo: AuthRepository(), homeRepo: HomeRepo())
            ..add(GetUserEvent())
            ..add(GetAllPlacesEvent())
            ..add(LoadSavedRecommendationsEvent()),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            var cubit = context.read<HomeBloc>();
            if (state is GetAllPlacesLoadingState) {
              isloading = true;
            } else if (state is GetAllPlacesSuccessState) {
              isloading = false;
              if (cubit.places == null || cubit.places!.isEmpty) {
                isimpty = true;
              }
            }
          },
          builder: (context, state) {
            var cubit = context.read<HomeBloc>();
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
                        HomeTextRow(RowText: 'Best Destinations'),
                        Gap(5),
                        isloading
                            ? Container(
                                height: 420,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : cubit.bestDestinations.isEmpty
                            ? ImptyWidget()
                            : HomeListWidget(places: cubit.bestDestinations),
                        const Gap(20),
                        _animatedCardWrapper(
                          HomeTextRow(RowText: 'Saved Recommendations'),
                          0,
                        ),
                        Gap(5),

                        _animatedCardWrapper(
                          const SavedRecommendationsHomeSection(),
                          2,
                        ),

                        const Gap(10),
                        _animatedCardWrapper(
                          HomeTextRow(RowText: 'Popular Package'),
                          4,
                        ),
                        Gap(5),

                        _animatedCardWrapper(
                          cubit.popularPackages.isEmpty
                              ? ImptyWidget()
                              : HomeListWidget(places: cubit.popularPackages),
                          5,
                        ),
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
                                const Gap(5),
                                if (user?.photoUrl != null)
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage(
                                      user!.photoUrl!,
                                    ),
                                  )
                                else
                                  Image.asset(
                                    AppAssets.personProfile,
                                    width: 36,
                                    height: 36,
                                  ),
                                const Gap(5),
                                Expanded(
                                  child: Text(
                                    user?.name ?? 'User Name',
                                    style: TextStyles.getSize12(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
      ),
    );
  }
}
