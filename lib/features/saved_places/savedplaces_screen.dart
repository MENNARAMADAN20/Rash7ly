import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/components/appbar/arrow_back_app_bar.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/home/model/place_class.dart';
import 'package:rash7ly/features/home/widgets/place_item.dart';

class SavedplacesScreen extends StatelessWidget {
  const SavedplacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Placeclass> savedplaces = Placeclass.savedplaces;
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
          child: SingleChildScrollView(
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
                    return PlaceItem(
                      image: savedplaces[index].image ?? AppAssets.error,
                      title: savedplaces[index].title ?? 'Unknown',
                      location: savedplaces[index].location ?? 'Unknown',
                      category: savedplaces[index].category ?? 'Unknown',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
