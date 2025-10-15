import 'package:rash7ly/core/constants/app_assets.dart';

// by ibarhim
class Placeclass {
  final String? image;
  final String? title;
  final String? location;

  Placeclass({
    required this.image,
    required this.title,
    required this.location,
  });

  static List<Placeclass> savedplaces = [
    Placeclass(
      image: AppAssets.saved1,
      title: 'Niladri Reservoir',
      location: 'Tekergat, Sunamgnj',
    ),
    Placeclass(
      image: AppAssets.saved2,
      title: 'Casa Las Tirtugas',
      location: 'Av Damero, Mexico',
    ),
    Placeclass(
      image: AppAssets.saved3,
      title: 'Aonang Villa Resort',
      location: 'Bastola, Islampur',
    ),
    Placeclass(
      image: AppAssets.saved4,
      title: 'Rangauti Resort',
      location: 'Sylhet, Airport Road',
    ),
    Placeclass(
      image: AppAssets.saved5,
      title: 'Kachura Resort',
      location: 'Vellima, Island',
    ),
    Placeclass(
      image: AppAssets.saved6,
      title: 'Shakardu Resort',
      location: 'Shakartu, Pakistan',
    ),
  ];
}
