import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      //  borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), 
            spreadRadius: 1,
            blurRadius: 8, 
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.greyColor),
            Gap(8),
            Text(
              text,
              style: TextStyles.getSize16(
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: AppColors.blackColor),
          ],
        ),
      ),
    );
  }
}
