import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

/// Manages user profile data.
class ProfileProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  ProfileProvider() {
    loadProfile();
  }

  /// Load user profile from Firestore.
  Future<void> loadProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _user = await _firestoreService.getUser(firebaseUser.uid);
      if (_user == null) {
        // Create a basic profile from Firebase Auth data
        _user = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName,
          photoURL: firebaseUser.photoURL,
        );
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Update user profile.
  Future<void> updateProfile(Map<String, dynamic> data) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.updateUser(firebaseUser.uid, data);
      // Reload profile
      await loadProfile();
    } catch (e) {
      debugPrint('Error updating profile: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get display name or fallback.
  String get displayName =>
      _user?.displayName ?? FirebaseAuth.instance.currentUser?.displayName ?? 'Athlete';

  /// Get user email.
  String get email =>
      _user?.email ?? FirebaseAuth.instance.currentUser?.email ?? '';

  /// Get user initials for avatar.
  String get initials {
    final name = displayName;
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
