import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class CategoryRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlaceModel>?> getPlacesByCategory(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('recommendations')
          .where('category', isEqualTo: category)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      List<PlaceModel> places = snapshot.docs.map((doc) {
        final data = doc.data();
        return PlaceModel(
          id: data['id'],
          title: data['name'],
          location: data['location'],
          category: data['category'],
          gallery: List<String>.from(data['images'] ?? []),
          description: data['description'],
          auther_id: data['userId'],
          createdAt: data['createdAt'],
        );
      }).toList();

      return places;
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch places by category: ${e.message}');
    }
  }
}
