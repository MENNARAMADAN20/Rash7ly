import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';
import 'package:rash7ly/features/home/data/repo/home_repo.dart';
import 'package:rash7ly/features/home/widgets/impty_widget.dart';

class SavedRecommendationsScreen extends StatelessWidget {
  const SavedRecommendationsScreen({super.key});

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
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leadingWidth: 60,
          leading: ArrowBackAppBar(),
          title: Text(
            "Saved Recommendations",
            style: TextStyles.getSize18(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current is SavedRecommendationsLoadingState ||
                current is SavedRecommendationsSuccessState ||
                current is SavedRecommendationsFailedState,
            builder: (context, state) {
              if (state is SavedRecommendationsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              final savedPlaces = context.read<HomeBloc>().savedPlaces;

              if (savedPlaces.isEmpty) {
                return Center(child: ImptyWidget());
              }

              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: savedPlaces.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final destination = savedPlaces[index];
                  return _buildCard(context, destination);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, PlaceModel destination) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.cardDetails, extra: {"card": destination}).then((
          value,
        ) {
          context.read<HomeBloc>().add(LoadSavedRecommendationsEvent());
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(-1, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                destination.gallery?.isNotEmpty == true
                    ? destination.gallery![0]
                    : '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          destination.title ?? 'No Title',
                          style: TextStyles.getSize16(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 18, color: Colors.amber),
                          const Gap(1.5),
                          Text(
                            destination.rating?.toStringAsFixed(1) ?? '0.0',
                            style: TextStyles.getSize16(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.locationIconSvg),
                                const Gap(2),
                                Text(
                                  destination.category ?? 'Unknown Category',
                                  style: TextStyles.getSize12(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.locationIconSvg),
                                const Gap(2),
                                Text(
                                  destination.location ?? 'Unknown Location',
                                  style: TextStyles.getSize12(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(AppAssets.groupIconSvg),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
