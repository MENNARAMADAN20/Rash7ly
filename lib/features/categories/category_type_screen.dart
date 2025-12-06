import 'package:flutter/material.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';
import 'package:rash7ly/features/home/widgets/place_item.dart';

class CategoryTypeScreen extends StatelessWidget {
  const CategoryTypeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final List<PlaceModel> places = PlaceModel.savedplaces;
    return Scaffold(
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
          child: SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .85,
                mainAxisSpacing: 25,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return PlaceItem(
                  //! by ibrahim
                  image: places[index].gallery?[0] ?? AppAssets.error,
                  title: places[index].title ?? 'Unknown',
                  location: places[index].location ?? 'Unknown',
                  category: places[index].location ?? 'Unknown',
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
