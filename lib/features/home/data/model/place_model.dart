import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rash7ly/features/home/data/model/saved_recomm/review_model.dart';

// by ibarhim
class PlaceModel {
  final String? id;
  final String? title;
  final String? location;
  final String? category;
  final List<String>? gallery;
  final String? description;
  final double? rating;
  final String? auther_id;
  final Timestamp? createdAt;
  final List<ReviewModel>? reviews;

  PlaceModel({
    this.id,
    this.gallery,
    this.description,
    this.rating,
    required this.title,
    required this.location,
    required this.category,
    this.auther_id,
    this.reviews,
    this.createdAt,
  });

  static List<PlaceModel> savedplaces = [
    // PlaceModel(
    //   image: AppAssets.saved1,
    //   title: 'Niladri Reservoir',
    //   location: 'Tekergat, Sunamgnj',
    //   category: 'Beach',
    // ),
    // PlaceModel(
    //   image: AppAssets.saved2,
    //   title: 'Casa Las Tirtugas',
    //   location: 'Av Damero, Mexico',
    //   category: 'Beach',
    // ),
    // PlaceModel(
    //   image: AppAssets.saved3,
    //   title: 'Aonang Villa Resort',
    //   location: 'Bastola, Islampur',
    //   category: 'Beach',
    // ),
    // PlaceModel(
    //   image: AppAssets.saved4,
    //   title: 'Rangauti Resort',
    //   location: 'Sylhet, Airport Road',
    //   category: 'Beach',
    // ),
    // PlaceModel(
    //   image: AppAssets.saved5,
    //   title: 'Kachura Resort',
    //   location: 'Vellima, Island',
    //   category: 'Beach',
    // ),
    // PlaceModel(
    //   image: AppAssets.saved6,
    //   title: 'Shakardu Resort',
    //   location: 'Shakartu, Pakistan',
    //   category: 'Beach',
    // ),
  ];
}
