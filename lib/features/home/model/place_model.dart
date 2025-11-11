import 'package:rash7ly/features/home/model/review_model.dart';

//! by ibrhaim
class PlaceModel {
  String? id;
  List<String>? images;
  String? name;
  String? description;
  String? city;
  String? location;
  double? price;
  double? rate;
  int? likes;
  String? date;
  String? ownerId;
  List<ReviewModel>? reviews;
  bool? isAccepted;

  PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.location,
    required this.price,
    required this.rate,
    required this.likes,
    required this.date,
    required this.ownerId,
    required this.reviews,
    required this.isAccepted,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      location: json['location'],
      price: json['price'],
      rate: json['rate'],
      likes: json['likes'],
      date: json['date'],
      ownerId: json['ownerId'],
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json['reviews'].map((x) => ReviewModel.fromJson(x)),
            )
          : [],
      isAccepted: json['isAccepted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'location': location,
      'price': price,
      'rate': rate,
      'likes': likes,
      'date': date,
      'ownerId': ownerId,
      'reviews': reviews != null
          ? List<dynamic>.from(reviews!.map((x) => x.toJson()))
          : [],
      'isAccepted': isAccepted,
    };
  }
}
