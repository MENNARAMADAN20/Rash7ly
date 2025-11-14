import 'package:flutter/material.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import 'package:rash7ly/features/home/model/Best_destinations.dart';
import 'package:rash7ly/features/home/model/saved_recomm/saved_service.dart';
import 'package:rash7ly/features/home/presentation/widgets/_build_icon.dart';

class UpperCard extends StatefulWidget {
  final BestDestination card;
  const UpperCard({super.key, required this.card});
  @override
  State<UpperCard> createState() => _UpperCardState();
}

class _UpperCardState extends State<UpperCard> {
  bool isSaved = false;
  @override
  void initState() {
    super.initState();
    isSaved = SavedService.isSaved(widget.card);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: buildicon(icon: Icons.arrow_back_ios_new),
              // icon: _build_icon(Icons.arrow_back_ios_new_rounded),
            ),

            IconButton(
              onPressed: () {
                setState(() {
                  SavedService.toggleSaved(widget.card);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.blueColor,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    content: Text(
                      "Added to Saved Recommendations",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? AppColors.blueColor : Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
