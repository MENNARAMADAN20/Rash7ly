import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';

class ImptyWidget extends StatelessWidget {
  const ImptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/bear.json', width: 200, height: 150),
            Text(
              'No Recommended Yet',
              style: TextStyle(color: AppColors.greyColor),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
