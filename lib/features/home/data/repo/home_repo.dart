//! by ibarhim
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class HomeRepo {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlaceModel>?> getplaces() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('recommendations')
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
      throw Exception('Failed to fetch places: ${e.message}');
    }
  }

  Future<PlaceModel?> getPlaceById(String placeId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('recommendations')
          .doc(placeId)
          .get();

      if (!doc.exists) {
        return null;
      }

      final data = doc.data()!;
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
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch place by ID: ${e.message}');
    }
  }
}
