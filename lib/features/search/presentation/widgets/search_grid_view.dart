import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class SearchGridView extends StatelessWidget {
  final String searchText;
  final List<PlaceModel>? places;

  const SearchGridView({
    super.key,
    required this.searchText,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = places!
        .where(
          (item) =>
              item.title!.toLowerCase().contains(searchText.toLowerCase()) ||
              item.location!.toLowerCase().contains(searchText.toLowerCase()),
        )
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
        return GestureDetector(
          onTap: () {
            pushTo(context, Routes.cardDetails, {"card": filtered[index]},);
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
                      child: Image.network(
                        filtered[index].gallery![0],
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
                            filtered[index].title!,
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
                                filtered[index].location!,
                                style: TextStyles.getSize12(
                                  fontSize: 13,
                                  color: AppColors.greyColor,
                                ),
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
