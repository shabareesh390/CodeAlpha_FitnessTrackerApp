import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/enums.dart';

/// User profile model with Firestore serialization.
class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final double? height; // cm
  final double? weight; // kg
  final int? age;
  final Gender? gender;
  final FitnessGoal? fitnessGoal;
  final int stepGoal;
  final int waterGoal; // ml
  final int calorieGoal;
  final DateTime? createdAt;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    this.height,
    this.weight,
    this.age,
    this.gender,
    this.fitnessGoal,
    this.stepGoal = 10000,
    this.waterGoal = 2500,
    this.calorieGoal = 500,
    this.createdAt,
  });

  /// Create from Firestore document.
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'] ?? doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoURL: data['photoURL'],
      height: (data['height'] as num?)?.toDouble(),
      weight: (data['weight'] as num?)?.toDouble(),
      age: data['age'] as int?,
      gender: data['gender'] != null
          ? Gender.values.firstWhere(
              (e) => e.name == data['gender'],
              orElse: () => Gender.preferNotToSay,
            )
          : null,
      fitnessGoal: data['fitnessGoal'] != null
          ? FitnessGoal.values.firstWhere(
              (e) => e.name == data['fitnessGoal'],
              orElse: () => FitnessGoal.stayFit,
            )
          : null,
      stepGoal: data['stepGoal'] ?? 10000,
      waterGoal: data['waterGoal'] ?? 2500,
      calorieGoal: data['calorieGoal'] ?? 500,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Convert to Firestore map.
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender?.name,
      'fitnessGoal': fitnessGoal?.name,
      'stepGoal': stepGoal,
      'waterGoal': waterGoal,
      'calorieGoal': calorieGoal,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  /// Create a copy with updated fields.
  UserModel copyWith({
    String? displayName,
    String? photoURL,
    double? height,
    double? weight,
    int? age,
    Gender? gender,
    FitnessGoal? fitnessGoal,
    int? stepGoal,
    int? waterGoal,
    int? calorieGoal,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      stepGoal: stepGoal ?? this.stepGoal,
      waterGoal: waterGoal ?? this.waterGoal,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      createdAt: createdAt,
    );
  }

  /// Calculate BMI if height and weight are available.
  double? get bmi {
    if (height == null || weight == null || height! <= 0) return null;
    final heightInMeters = height! / 100;
    return weight! / (heightInMeters * heightInMeters);
  }

  /// Get BMI category string.
  String? get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue == null) return null;
    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }
}
