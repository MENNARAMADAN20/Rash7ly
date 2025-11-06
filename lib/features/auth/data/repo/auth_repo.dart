import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );

      await _firestore.collection('users').doc(user.id).set(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An error occurred during sign up: $e');
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await getUserById(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception('An error occurred during sign in: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('An error occurred during sign out: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      return await getUserById(user.uid);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw Exception('User not found');
      }

      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'email-already-in-use':
        return 'This email is already registered. Try signing in or use a different email.';
      case 'user-not-found':
        return 'No account found for that email. Please check the email or sign up.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-email':
        return 'The email address appears to be invalid. Please check the format.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support if you think this is an error.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a moment and try again.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Contact support.';
      default:
        return e.message ??
            'An authentication error occurred. Please try again.';
    }
  }

  // Sign in with Google using Firebase provider API (web: popup, native: provider)
  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleProvider = fb.GoogleAuthProvider();
      final result = kIsWeb
          ? await _firebaseAuth.signInWithPopup(googleProvider)
          : await _firebaseAuth.signInWithProvider(googleProvider);
      final fb.User? u = result.user;
      if (u == null) return null;
      final userModel = UserModel.fromFirebaseUser(u, provider: 'google');
      await _saveUser(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Facebook using Firebase provider API
  Future<UserModel?> signInWithFacebook() async {
    try {
      final facebookProvider = fb.FacebookAuthProvider();
      final result = kIsWeb
          ? await _firebaseAuth.signInWithPopup(facebookProvider)
          : await _firebaseAuth.signInWithProvider(facebookProvider);
      final fb.User? u = result.user;
      if (u == null) return null;
      final userModel = UserModel.fromFirebaseUser(u, provider: 'facebook');
      await _saveUser(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Twitter using Firebase provider API
  Future<UserModel?> signInWithTwitter() async {
    try {
      final twitterProvider = fb.TwitterAuthProvider();
      final result = kIsWeb
          ? await _firebaseAuth.signInWithPopup(twitterProvider)
          : await _firebaseAuth.signInWithProvider(twitterProvider);
      final fb.User? u = result.user;
      if (u == null) return null;
      final userModel = UserModel.fromFirebaseUser(u, provider: 'twitter');
      await _saveUser(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveUser(UserModel u) async {
    await _firestore
        .collection('users')
        .doc(u.id)
        .set(u.toMap(), SetOptions(merge: true));
  }
}
