import 'package:cloud_firestore/cloud_firestore.dart';

/// Daily activity tracking data.
class ActivityModel {
  final String id;
  final DateTime date;
  final int steps;
  final double distance; // km
  final int calories;
  final int floors;
  final int activeMinutes;
  final int heartRate; // bpm average
  final double? cyclingDistance;
  final double? runningDistance;
  final double? walkingDistance;

  const ActivityModel({
    required this.id,
    required this.date,
    this.steps = 0,
    this.distance = 0,
    this.calories = 0,
    this.floors = 0,
    this.activeMinutes = 0,
    this.heartRate = 72,
    this.cyclingDistance,
    this.runningDistance,
    this.walkingDistance,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'date': Timestamp.fromDate(date),
      'steps': steps,
      'distance': distance,
      'calories': calories,
      'floors': floors,
      'activeMinutes': activeMinutes,
      'heartRate': heartRate,
      'cyclingDistance': cyclingDistance,
      'runningDistance': runningDistance,
      'walkingDistance': walkingDistance,
    };
  }

  factory ActivityModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return ActivityModel(
      id: docId,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      steps: data['steps'] ?? 0,
      distance: (data['distance'] as num?)?.toDouble() ?? 0,
      calories: data['calories'] ?? 0,
      floors: data['floors'] ?? 0,
      activeMinutes: data['activeMinutes'] ?? 0,
      heartRate: data['heartRate'] ?? 72,
      cyclingDistance: (data['cyclingDistance'] as num?)?.toDouble(),
      runningDistance: (data['runningDistance'] as num?)?.toDouble(),
      walkingDistance: (data['walkingDistance'] as num?)?.toDouble(),
    );
  }
}
