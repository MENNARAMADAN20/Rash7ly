import 'package:flutter/material.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';

class ArrowBackAppBar extends StatelessWidget {
  const ArrowBackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 15),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.arrow_back_ios_new_rounded)],
        ),
      ),
    );
  }
}
