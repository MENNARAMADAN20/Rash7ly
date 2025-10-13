import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 335,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.searchIcon),
              Gap(7),
              Expanded(
                child: TextField(
                  onChanged: (value) {},
                  style: TextStyles.getSize16(
                    color: AppColors.blackColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search Places',
                    hintStyle: TextStyles.getSize16(
                      color: AppColors.greyColor,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
