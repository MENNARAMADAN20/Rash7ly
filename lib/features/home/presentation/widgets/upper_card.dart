import 'package:flutter/material.dart';
import 'package:rash7ly/features/home/presentation/widgets/_build_icon.dart';

class UpperCard extends StatelessWidget {
  const UpperCard({super.key});

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
              onPressed: () {},
              icon: buildicon(icon: Icons.bookmark_border),
            ),
          ],
        ),
      ),
    );
  }
}
