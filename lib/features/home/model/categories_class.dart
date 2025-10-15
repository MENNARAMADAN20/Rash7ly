import 'package:rash7ly/core/constants/app_assets.dart';

// by ibrahim
class CategoriesClass {
  final String? image;
  final String? name;
  final int? count;

  CategoriesClass({
    required this.image,
    required this.name,
    required this.count,
  });

  static List<CategoriesClass> categories = [
    CategoriesClass(image: AppAssets.beach, name: 'Beaches', count: 20),
    CategoriesClass(image: AppAssets.mountain, name: 'Mountaines', count: 15),
    CategoriesClass(image: AppAssets.city, name: 'Cities', count: 18),
    CategoriesClass(image: AppAssets.park, name: 'Natura Parks', count: 22),
    CategoriesClass(image: AppAssets.beach, name: 'Beaches', count: 20),
    CategoriesClass(image: AppAssets.beach, name: 'Beaches', count: 20),
  ];
}
