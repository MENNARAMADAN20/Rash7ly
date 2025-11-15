import 'package:rash7ly/core/constants/app_assets.dart';

// by ibarhim
class Placeclass {
  final String? image;
  final String? title;
  final String? location;
  final String? category;

  Placeclass({
    required this.image,
    required this.title,
    required this.location,
    required this.category,
  });

  static List<Placeclass> savedplaces = [
    Placeclass(
      image: AppAssets.saved1,
      title: 'Niladri Reservoir',
      location: 'Tekergat, Sunamgnj',
      category: 'Beach',
    ),
    Placeclass(
      image: AppAssets.saved2,
      title: 'Casa Las Tirtugas',
      location: 'Av Damero, Mexico',
      category: 'Beach',
    ),
    Placeclass(
      image: AppAssets.saved3,
      title: 'Aonang Villa Resort',
      location: 'Bastola, Islampur',
      category: 'Beach',
    ),
    Placeclass(
      image: AppAssets.saved4,
      title: 'Rangauti Resort',
      location: 'Sylhet, Airport Road',
      category: 'Beach',
    ),
    Placeclass(
      image: AppAssets.saved5,
      title: 'Kachura Resort',
      location: 'Vellima, Island',
      category: 'Beach',
    ),
    Placeclass(
      image: AppAssets.saved6,
      title: 'Shakardu Resort',
      location: 'Shakartu, Pakistan',
      category: 'Beach',
    ),
  ];
}
