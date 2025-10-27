import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/model/places_class.dart';

class BestDestinationListWidget extends StatelessWidget {
  const BestDestinationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: BestDestination.cards.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final destination = BestDestination.cards[index];
          //! this GestureDetector by ibrahim
          return GestureDetector(
            onTap: () => pushTo(context, Routes.cardDetails),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 268,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.asset(
                        destination.image,
                        height: 286,
                        width: double.infinity,
                        fit: BoxFit.contain,
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
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                  Gap(1.5),
                                  Text(
                                    destination.rate.toString(),
                                    style: TextStyles.getSize16(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(10),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.locationIconSvg,
                                        ),
                                        Gap(2),
                                        Text(
                                          destination.category,
                                          style: TextStyles.getSize12(
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(5),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.locationIconSvg,
                                        ),
                                        Gap(2),
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
            ),
          );
        },
      ),
    );
  }
}
