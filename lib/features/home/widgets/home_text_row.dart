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
          GestureDetector(
            onTap: () {
              if (RowText == 'Best Destinations') {
                context.push(Routes.search);
                return;
              }
              if (RowText == 'Saved Recommendations') {
                context.push(Routes.search);
                return;
              }
              if (RowText == 'Popular Package') {
                context.push(Routes.search);
                return;
              }
            },
            child: Text(
              'View all',
              style: TextStyle(color: AppColors.blueColor),
            ),
          ),
        ],
      ),
    );
  }
}
