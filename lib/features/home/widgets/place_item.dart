import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class PlaceItem extends StatefulWidget {
  const PlaceItem({
    super.key,
    required this.image,
    required this.title,
    required this.location,
  });

  final String image;
  final String title;
  final String location;

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  bool isfav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushTo(context, Routes.cardDetails),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.asset(
                      widget.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.getSize16(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.locationIconSvg,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              AppColors.greyColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Gap(5),
                          Expanded(
                            child: Text(
                              widget.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.getSize12(
                                fontSize: 13,
                                color: AppColors.greyColor,
                              ),
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
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isfav = !isfav;
                });
              },
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor.withValues(alpha: 0.5),
                child: Icon(
                  isfav ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
