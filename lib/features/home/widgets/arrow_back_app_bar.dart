import 'package:flutter/material.dart';
import 'package:rash7ly/core/routes/navigation.dart';

class ArrowBackAppBar extends StatelessWidget {
  const ArrowBackAppBar({super.key,
  required this.backgroundColor,
  required this.iconColor
  });
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 15),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.arrow_back_ios_new_rounded,color: iconColor,)],
        ),
      ),
    );
  }
}
