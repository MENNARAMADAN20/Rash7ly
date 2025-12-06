// import 'package:flutter/material.dart';
// import 'package:rash7ly/core/constants/app_assets.dart';
// // import 'package:rash7ly/features/home/data/model/Best_destinations.dart';
// import 'package:rash7ly/features/home/data/model/place_model.dart';

// class CardPhoto extends StatelessWidget {
//   final PlaceModel card;
//   final String tag;

//   const CardPhoto({super.key, required this.card, required this.tag});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300,
//       width: double.infinity,
//       child: Hero(
//         tag: tag,
//         //! by ibrahim
//         child: card.gallery != null && card.gallery!.isNotEmpty
//             ? Image.network(
//                 card.gallery![0],
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               )
//             : Image.asset(
//                 AppAssets.error,
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//         // child: Image.network(
//         //   card.gallery![0].isNotEmpty ? card.gallery![0] : '',
//         //   width: double.infinity,
//         //   height: double.infinity,
//         //   fit: BoxFit.cover,
//         // ),
//       ),
//     );
//   }
// }
