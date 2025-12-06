import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/bloc/home_bloc.dart';
import 'package:rash7ly/features/home/widgets/impty_widget.dart';
import 'package:rash7ly/features/categories/presentaion/widgets/place_item.dart';

class SavedplacesScreen extends StatelessWidget {
  const SavedplacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 60,
        leading: ArrowBackAppBar(),
        title: Text(
          "Saved Recommendations",
          style: TextStyles.getSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current is SavedRecommendationsLoadingState ||
                current is SavedRecommendationsSuccessState ||
                current is SavedRecommendationsFailedState,
            builder: (context, state) {
              if (state is SavedRecommendationsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              final savedplaces = context.read<HomeBloc>().savedPlaces;

              if (savedplaces.isEmpty) {
                return Center(child: ImptyWidget());
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved Places',
                      style: TextStyles.getSize20(fontWeight: FontWeight.w600),
                    ),
                    Gap(15),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: savedplaces.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .85,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 15,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return PlaceItem(place: savedplaces[index]);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
