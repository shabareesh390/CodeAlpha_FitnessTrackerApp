import 'package:cloud_firestore/cloud_firestore.dart';

/// Aggregated daily statistics for dashboard display.
class DailyStatsModel {
  final String id;
  final DateTime date;
  final int steps;
  final int caloriesBurned;
  final int activeMinutes;
  final int workoutDuration; // minutes
  final int waterIntake; // ml
  final double sleepDuration; // hours
  final int heartRate; // bpm
  final double? weight; // kg

  const DailyStatsModel({
    required this.id,
    required this.date,
    this.steps = 0,
    this.caloriesBurned = 0,
    this.activeMinutes = 0,
    this.workoutDuration = 0,
    this.waterIntake = 0,
    this.sleepDuration = 0,
    this.heartRate = 72,
    this.weight,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'date': Timestamp.fromDate(date),
      'steps': steps,
      'caloriesBurned': caloriesBurned,
      'activeMinutes': activeMinutes,
      'workoutDuration': workoutDuration,
      'waterIntake': waterIntake,
      'sleepDuration': sleepDuration,
      'heartRate': heartRate,
      'weight': weight,
    };
  }

  factory DailyStatsModel.fromFirestore(
      Map<String, dynamic> data, String docId) {
    return DailyStatsModel(
      id: docId,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      steps: data['steps'] ?? 0,
      caloriesBurned: data['caloriesBurned'] ?? 0,
      activeMinutes: data['activeMinutes'] ?? 0,
      workoutDuration: data['workoutDuration'] ?? 0,
      waterIntake: data['waterIntake'] ?? 0,
      sleepDuration: (data['sleepDuration'] as num?)?.toDouble() ?? 0,
      heartRate: data['heartRate'] ?? 72,
      weight: (data['weight'] as num?)?.toDouble(),
    );
  }
}
