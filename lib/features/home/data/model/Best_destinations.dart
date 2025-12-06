import 'package:rash7ly/core/constants/app_assets.dart';

class BestDestination {
  final String image;
  final String name; //Tarshe7 Name
  final String category;
  final String city;
  final double rate;

  BestDestination({
    required this.image,
    required this.name,
    required this.category,
    required this.city,
    required this.rate,
  });

  static List<BestDestination> cards = [
    BestDestination(
      image: AppAssets.image1,
      name: 'Rangauti Resort',
      category: 'Beach',
      city: 'Miami',
      rate: 4.8,
    ),
    BestDestination(
      image: AppAssets.image2,
      name: 'Darma Reservoir',
      category: 'Mountain',
      city: 'Aspen',
      rate: 4.5,
    ),
    BestDestination(
      image: AppAssets.image3,
      name: 'Niladri Reservoir',
      category: 'City',
      city: 'New York',
      rate: 4.7,
    ),
    BestDestination(
      image: AppAssets.image1,
      name: 'Desert Adventure',
      category: 'Desert',
      city: 'Dubai',
      rate: 4.6,
    ),
    BestDestination(
      image: AppAssets.image5,
      name: 'Aonang Villa Resort',
      category: 'Island',
      city: 'Maldives',
      rate: 4.9,
    ),
  ];
}

class SearchCards {
  final String name; //Tarshe7 Name
  final String location;
  final String pricePerPerson;
  final String image;

  SearchCards({
    required this.name,
    required this.location,
    required this.pricePerPerson,
    required this.image,
  });

  static List<SearchCards> cards = [
    SearchCards(
      name: 'Niladri Reservoir',
      location: 'Tekergat',
      pricePerPerson: '\$894',
      image: AppAssets.image1,
    ),
    SearchCards(
      name: 'Casa Las Tirtugas',
      location: 'Av Damero',
      pricePerPerson: '\$894',
      image: AppAssets.image2,
    ),
    SearchCards(
      name: 'Aonang Villa Resort',
      location: 'Bastola',
      pricePerPerson: '\$761',
      image: AppAssets.image3,
    ),
    SearchCards(
      name: 'Rangauti Resort',
      location: 'Sylhet',
      pricePerPerson: '\$857',
      image: AppAssets.image4,
    ),
  ];
}
