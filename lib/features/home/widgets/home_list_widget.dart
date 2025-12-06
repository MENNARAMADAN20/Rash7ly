import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class HomeListWidget extends StatefulWidget {
  const HomeListWidget({super.key, required this.places});

  final List<PlaceModel>? places;

  @override
  State<HomeListWidget> createState() => _HomeListWidgetState();
}

class _HomeListWidgetState extends State<HomeListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: widget.places!.length,
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            // final destination = BestDestination.cards[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(
                horizontalOffset: 40.0,
                curve: Curves.easeOutCubic,
                child: FadeInAnimation(
                  child: _buildCard(context, widget.places![index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, PlaceModel place) {
  return GestureDetector(
    onTap: () {
      context.push(Routes.cardDetails, extra: {"card": place}).then((value) {
        context.read<HomeBloc>().add(LoadSavedRecommendationsEvent());
      });
    },

    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 268,
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            // child: Hero(
            //   tag: "home_${destination.image}",
            //   child: Image.asset(
            //     destination.image,
            //     height: 286,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Image.network(
              place.gallery!.isNotEmpty ? place.gallery![0] : '', //
              height: 286,
              width: double.infinity,
              fit: BoxFit.cover,
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
                        // destination.name,
                        place.title ?? '',
                        maxLines: 1,
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
                          // destination.rate.toString(),
                          place.rating?.toStringAsFixed(1) ?? '0.0',
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
                                // destination.category,
                                place.category ?? 'Unknown Category',
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
                                // destination.city,
                                place.location ?? 'Unknown Location',
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
