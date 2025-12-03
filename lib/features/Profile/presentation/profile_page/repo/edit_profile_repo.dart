import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rash7ly/core/services/local/local_helper.dart';
import 'package:rash7ly/features/auth/data/models/user_model.dart';

class UpdateProfile {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProfile({
    required String userId,
    String? newName,
    String? newPhotoUrl,
  }) async {
    final updates = <String, dynamic>{};

    if (newName != null && newName.trim().isNotEmpty) {
      updates['name'] = newName;
    }

    if (newPhotoUrl != null && newPhotoUrl.trim().isNotEmpty) {
      updates['photoUrl'] = newPhotoUrl;
    }

    // 1) Update Firestore
    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(userId).update(updates);
    }

    // 2) Update local storage
    final oldUser = LocalHelper.getUserData();
    if (oldUser != null) {
      final updatedUser = UserModel(
        id: oldUser.id,
        name: newName ?? oldUser.name,
        email: oldUser.email,
        photoUrl: newPhotoUrl ?? oldUser.photoUrl,
        provider: oldUser.provider,
      );
      LocalHelper.setUserData(updatedUser);
    }
  }
}
