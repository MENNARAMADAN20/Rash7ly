import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/core/routes/navigation.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 6500), () {
      pushTo(context, Routes.onBoard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: LottieBuilder.asset(
                AppAssets.splashLottie,
                repeat: false,
                width: 300,
              ),
            ),

            FutureBuilder(
              future: Future.delayed(Duration(seconds: 2)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                } else {
                  return Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 100,
                    right: (MediaQuery.of(context).size.width / 2) - 100,
                    bottom: 50,
                    child: LottieBuilder.asset(
                      AppAssets.welcomeLottie,
                      width: 100,
                      repeat: false,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
