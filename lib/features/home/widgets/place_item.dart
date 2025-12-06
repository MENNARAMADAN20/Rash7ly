import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
// import 'package:rash7ly/features/home/data/model/Best_destinations.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class SavedService {
  static final Set<String> _savedTitles = {};

  static bool isSaved(String title) => _savedTitles.contains(title);

  static void toggleSaved(String title) {
    if (isSaved(title)) {
      _savedTitles.remove(title);
    } else {
      _savedTitles.add(title);
    }
  }
}

class PlaceItem extends StatefulWidget {
  const PlaceItem({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.category,
  });

  final String image;
  final String title;
  final String location;
  final String category;

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    final isFav = SavedService.isSaved(widget.title);

    return GestureDetector(
      onTap: () {
        final PlaceModel card = PlaceModel(
          title: widget.title,
          location: widget.location,
          gallery: [widget.image],
          category: widget.category,
          rating: 0,
        );
        pushTo(context, Routes.cardDetails, {'card': card});
      },
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 250,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: widget.image.startsWith('http')
                        ? Image.network(
                            widget.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AppAssets.error, fit: BoxFit.cover),
                          )
                        : Image.asset(
                            widget.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: SingleChildScrollView(
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
                        const Gap(2),
                        Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              size: 16,
                              color: AppColors.greyColor,
                            ),
                            const Gap(4),
                            Expanded(
                              child: Text(
                                widget.category,
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
                  SavedService.toggleSaved(widget.title);
                });
                _showSavedDialog();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor.withOpacity(0.5),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSavedDialog() {
    final isFav = SavedService.isSaved(widget.title);
    final message = isFav
        ? "${widget.title} Added to favorites!"
        : "${widget.title} removed from favorites!";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return Container(
          height: 100,
          margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
