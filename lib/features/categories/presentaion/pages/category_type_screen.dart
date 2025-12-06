import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/categories/bloc/category_bloc.dart';
import 'package:rash7ly/features/categories/data/repo/category_repo.dart';
import 'package:rash7ly/features/categories/presentaion/widgets/place_item.dart';

class CategoryTypeScreen extends StatelessWidget {
  const CategoryTypeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryBloc(categoryRepo: CategoryRepo())
            ..add(GetPlacesByCategoryEvent(title)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leadingWidth: 60,
          leading: ArrowBackAppBar(),
          title: Text(
            title,
            style: TextStyles.getSize18(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CategoryFailedState) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyles.getSize14(color: Colors.red),
                    ),
                  );
                }

                if (state is CategoryEmptyState) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyles.getSize14(color: AppColors.greyColor),
                    ),
                  );
                }

                if (state is CategorySuccessState) {
                  final places = state.places;
                  return SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: places.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .85,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 15,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return PlaceItem(place: places[index]);
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
