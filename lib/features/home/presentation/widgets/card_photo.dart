import 'package:flutter/material.dart';
import 'package:rash7ly/features/home/model/Best_destinations.dart';

class CardPhoto extends StatelessWidget {
  final BestDestination card;
  final String tag;

  const CardPhoto({super.key, required this.card, required this.tag});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Hero(
        tag: tag,
        child: Image.asset(
          card.image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
