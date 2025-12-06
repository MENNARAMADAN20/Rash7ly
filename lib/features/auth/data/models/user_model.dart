import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserModel {
  final String id;
  final String email;
  final String name;
  String? photoUrl;
  final String? provider; // e.g. "google", "facebook", "twitter", "email"
  final List<String> savedRecommendationIds;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.provider,
    this.savedRecommendationIds = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> m) => UserModel(
    id: m['id'] ?? '',
    email: m['email'] ?? '',
    name: m['name'] ?? '',
    photoUrl: m['photoUrl'],
    provider: m['provider'],
    savedRecommendationIds: List<String>.from(
      m['savedRecommendationIds'] ?? [],
    ),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'name': name,
    'photoUrl': photoUrl,
    'provider': provider,
    'savedRecommendationIds': savedRecommendationIds,
  };

  // convenience factory for Firebase User
  factory UserModel.fromFirebaseUser(fb.User firebaseUser, {String? provider}) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name:
          firebaseUser.displayName ??
          (firebaseUser.email?.split('@').first ?? ''),
      photoUrl: firebaseUser.photoURL,
      provider: provider,
    );
  }
}
