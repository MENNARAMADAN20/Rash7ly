import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';
import 'package:rash7ly/features/home/presentation/widgets/_build_icon.dart';

class UpperCard extends StatelessWidget {
  final PlaceModel card;
  const UpperCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          current is ToggleSaveSuccessState ||
          current is SavedRecommendationsSuccessState,
      builder: (context, state) {
        final homeBloc = context.read<HomeBloc>();
        final isSaved = homeBloc.isPlaceSaved(card.id);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: buildicon(icon: Icons.arrow_back_ios_new),
                ),
                IconButton(
                  onPressed: () {
                    homeBloc.add(ToggleSaveRecommendationEvent(card));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.blueColor,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        content: Text(
                          !isSaved
                              ? "Added to Saved Recommendations"
                              : "Removed from Saved Recommendations",
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.blueColor : Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
