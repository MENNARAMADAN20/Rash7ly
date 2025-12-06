import 'package:cloud_firestore/cloud_firestore.dart';

class Recommendation {
  final String id;
  final String name;
  final String description;
  final String location;
  final String category;
  final List<String>
  images; // urls (can be local paths placeholder until upload)
  final Timestamp? createdAt;
  bool BestDestinations = false;
  bool PopularPackage = false;

  Recommendation({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    this.images = const [],
    this.createdAt,
    this.BestDestinations = false,
    this.PopularPackage = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'location': location,
    'category': category,
    'images': images,
    'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    'BestDestinations': BestDestinations,
    'PopularPackage': PopularPackage,
  };

  factory Recommendation.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Recommendation(
      id: data['id'] ?? doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      category: data['category'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      createdAt: data['createdAt'],
      BestDestinations: data['BestDestinations'] ?? false,
      PopularPackage: data['PopularPackage'] ?? false,
    );
  }
}
