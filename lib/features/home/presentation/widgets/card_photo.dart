import 'package:flutter/material.dart';
import 'package:rash7ly/core/constants/app_assets.dart';

class CardPhoto extends StatelessWidget {
  const CardPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "image", //model.name
      child: Image.asset(
        AppAssets.natureBird,
        //    model.image,
        fit: BoxFit.cover,
        height: 900,
        width: 900,
      ),
    );
  }
}
