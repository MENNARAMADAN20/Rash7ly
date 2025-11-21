import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/services/cloudinare_service/cloudinary_service.dart';

class AddRecommendationRepo {
  final FirebaseFirestore _firestore;
  final CloudinaryService _cloudinary;

  AddRecommendationRepo({
    FirebaseFirestore? firestore,
    required CloudinaryService cloudinary,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _cloudinary = cloudinary;

  /// Uploads images to Cloudinary (optional) and creates a Firestore doc.
  /// onUploadProgress receives 0.0 - 1.0
  Future<DocumentReference<Map<String, dynamic>>> addRecommendation({
    required String name,
    required String description,
    required String location,
    required String category,
    required String userId,
    List<File>? images,
    void Function(double)? onUploadProgress,
  }) async {
    final docRef = _firestore.collection('recommendations').doc();
    List<String> urls = [];

    if (images != null && images.isNotEmpty) {
      urls = await _cloudinary.uploadFiles(
        images,
        onOverallProgress: onUploadProgress,
      );
    }

    final data = {
      'id': docRef.id,
      'name': name,
      'description': description,
      'location': location,
      'category': category,
      'images': urls,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await docRef.set(data);
    return docRef;
  }
}
