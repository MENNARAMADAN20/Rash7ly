import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

// by ibrahim
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
    return Stack(
      children: [
        Container(
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
                    child: Image.asset(widget.image, fit: BoxFit.cover),
                  ),

                  Gap(5),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: GestureDetector(
            onTap: () {
              // add to fav <<<<<<<<<<<<
              isfav = !isfav;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor: AppColors.whiteColor.withValues(alpha: 0.5),
              child: isfav == false
                  ? Icon(Icons.favorite_outline, color: Colors.red)
                  : Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
