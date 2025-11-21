import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/model/Best_destinations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeListWidget extends StatelessWidget {
  const HomeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: AnimationLimiter(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: BestDestination.cards.length,
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            final destination = BestDestination.cards[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(
                horizontalOffset: 40.0,
                curve: Curves.easeOutCubic,
                child: FadeInAnimation(
                  child: _buildCard(context, destination),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, BestDestination destination) {
    return GestureDetector(
      onTap: () {
  context.push(
    Routes.cardDetails,
    extra: {
      "card": destination,
      "tag": destination.image,
    },
  );
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Hero(
                tag: destination.image,
                child: Image.asset(
                  destination.image,
                  height: 286,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
                          destination.name,
                          style: TextStyles.getSize16(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 18, color: Colors.amber),
                          const Gap(1.5),
                          Text(
                            destination.rate.toString(),
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
                                  destination.category,
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
                                  destination.city,
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
