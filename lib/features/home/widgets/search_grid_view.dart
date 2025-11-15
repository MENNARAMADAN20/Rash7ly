import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/model/Best_destinations.dart';

class SearchGridView extends StatelessWidget {
  final String searchText;

  const SearchGridView({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    final filtered = SearchCards.cards
        .where((item) =>
            item.name.toLowerCase().contains(searchText.toLowerCase()) ||
            item.location.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 15,
        childAspectRatio: 161 / 190,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final s = filtered[index];

        final BestDestination card = BestDestination(
          name: s.name,
          city: s.location,
          image: s.image,
          rate: 4.5,
          category: "General",
        );

        return GestureDetector(
          onTap: () {
            pushTo(
              context,
              Routes.cardDetails,
              {
                "card": card,
                "tag": s.name,
              },
            );
          },
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
                        s.image,
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
                            s.name,
                            style: TextStyles.getSize16(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.locationIconSvg),
                              Gap(4),
                              Text(
                                s.location,
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
                                s.pricePerPerson,
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
