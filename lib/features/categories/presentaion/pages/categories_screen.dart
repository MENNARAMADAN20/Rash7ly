import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';
import 'package:rash7ly/features/categories/data/models/categories_class.dart';
import 'package:rash7ly/features/categories/presentaion/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leadingWidth: 60,
        title: Text(
          "Categories",
          style: TextStyles.getSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: CategoriesClass.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 35,
                childAspectRatio: 0.71,
              ),
              itemBuilder: (context, index) {
                return CategoryItem(
                  image: CategoriesClass.categories[index].image,
                  title: CategoriesClass.categories[index].name,
                  count: CategoriesClass.categories[index].count,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
