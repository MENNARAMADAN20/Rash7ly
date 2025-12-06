import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class PlaceItem extends StatefulWidget {
  const PlaceItem({super.key, required this.place});

  final PlaceModel place;

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is ToggleSaveSuccessState ||
          current is SavedRecommendationsSuccessState,
      builder: (context, state) {
        final homeBloc = context.read<HomeBloc>();
        final isFav = homeBloc.isPlaceSaved(widget.place.id);

        return GestureDetector(
          onTap: () {
            pushTo(context, Routes.cardDetails, {'card': widget.place});
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
                        child: _buildImage(),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.place.title ?? 'Unknown',
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
                                    widget.place.location ?? 'Unknown',
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
                                    widget.place.category ?? 'Unknown',
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
                    homeBloc.add(ToggleSaveRecommendationEvent(widget.place));
                    _showSavedDialog(!isFav);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor.withOpacity(0.2),
                      child: Icon(
                        isFav ? Icons.bookmark : Icons.bookmark_border,
                        color: AppColors.yellowColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    final gallery = widget.place.gallery;
    if (gallery != null && gallery.isNotEmpty) {
      final imageUrl = gallery[0];
      if (imageUrl.startsWith('http')) {
        return Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Image.asset(AppAssets.error, fit: BoxFit.cover),
        );
      } else {
        return Image.asset(imageUrl, width: double.infinity, fit: BoxFit.cover);
      }
    }
    return Image.asset(AppAssets.error, fit: BoxFit.cover);
  }

  void _showSavedDialog(bool wasSaved) {
    final message = wasSaved
        ? "${widget.place.title ?? 'Item'} Added to favorites!"
        : "${widget.place.title ?? 'Item'} removed from favorites!";

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
