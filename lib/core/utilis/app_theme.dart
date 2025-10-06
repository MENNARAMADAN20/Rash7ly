import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class AppTheme {
  static get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: 'Poppins',
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getSize16(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(14),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(14),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
  static get darkTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.darkModeColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getSize16(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(14),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(14),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGreyColor),
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}
