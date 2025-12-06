//! by ibarhim
import 'dart:developer';

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
          bestDestinations: data['BestDestinations'] == true,
          popularPackage: data['PopularPackage'] == true,
        );
      }).toList();

      return places;
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch places: ${e.message}');
    }
  }

  Future<PlaceModel?> getPlaceById(String placeId) async {
    log('getPlaceById called with placeId: $placeId');
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('recommendations')
          .doc(placeId)
          .get();

      if (!doc.exists) {
        log('getPlaceById: document does NOT exist for placeId: $placeId');
        return null;
      }

      log('getPlaceById: document FOUND for placeId: $placeId');
      final data = doc.data()!;
      final place = PlaceModel(
        id: data['id'],
        title: data['name'],
        location: data['location'],
        category: data['category'],
        gallery: List<String>.from(data['images'] ?? []),
        description: data['description'],
        auther_id: data['userId'],
        createdAt: data['createdAt'],
        bestDestinations: data['BestDestinations'] == true,
        popularPackage: data['PopularPackage'] == true,
      );
      log('getPlaceById: returning PlaceModel with title: ${place.title}');
      return place;
    } on FirebaseException catch (e) {
      log('getPlaceById: FirebaseException: ${e.message}');
      throw Exception('Failed to fetch place by ID: ${e.message}');
    }
  }
}
