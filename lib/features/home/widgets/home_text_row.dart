import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rash7ly/core/routes/routes.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/core/utilis/text_style.dart';

class HomeTextRow extends StatelessWidget {
  const HomeTextRow({super.key, required this.RowText});

  final String RowText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              RowText,
              style: TextStyles.getSize20(fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              if (RowText == "Saved Recommendations") {
                context.push(Routes.savedRecommendations);
              }
            },
            child: GestureDetector(
              onTap: () {
                context.push(Routes.search);
              },
              child: Text(
                'View all',
                style: TextStyle(color: AppColors.blueColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
