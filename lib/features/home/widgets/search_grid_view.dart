import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/model/places_class.dart';

class SearchGridView extends StatelessWidget {
  const SearchGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 15,
        childAspectRatio: 161 / 190,
      ),
      itemCount: SearchCards.cards.length,
      itemBuilder: (context, index) {
        final card = SearchCards.cards[index];
        //! this GestureDetector added by ibrahim
        return GestureDetector(
          onTap: () => pushTo(context, Routes.cardDetails),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        card.image,
                        width: 160,
                        height: 124,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Gap(5),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.name,
                            style: TextStyles.getSize16(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.locationIconSvg),
                              Gap(4),
                              Text(
                                card.location,
                                style: TextStyles.getSize12(
                                  fontSize: 13,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                          Gap(5),
                          Row(
                            children: [
                              Text(
                                card.pricePerPerson,
                                style: TextStyle(color: AppColors.blueColor),
                              ),
                              Text(
                                '/Person',
                                style: TextStyle(color: AppColors.greyColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
