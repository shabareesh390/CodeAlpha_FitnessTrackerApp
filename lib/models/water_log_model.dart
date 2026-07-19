import 'package:cloud_firestore/cloud_firestore.dart';

/// Water intake log for a single day.
class WaterLogModel {
  final String id;
  final DateTime date;
  final int totalMl;
  final int goalMl;
  final List<WaterEntry> entries;

  const WaterLogModel({
    required this.id,
    required this.date,
    this.totalMl = 0,
    this.goalMl = 2500,
    this.entries = const [],
  });

  /// Progress percentage (0.0 - 1.0).
  double get progress => goalMl > 0 ? (totalMl / goalMl).clamp(0.0, 1.0) : 0.0;

  /// Remaining ml to reach goal.
  int get remaining => (goalMl - totalMl).clamp(0, goalMl);

  /// Whether goal has been reached.
  bool get isGoalReached => totalMl >= goalMl;

  Map<String, dynamic> toFirestore() {
    return {
      'date': Timestamp.fromDate(date),
      'totalMl': totalMl,
      'goalMl': goalMl,
      'entries': entries.map((e) => e.toMap()).toList(),
    };
  }

  factory WaterLogModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return WaterLogModel(
      id: docId,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalMl: data['totalMl'] ?? 0,
      goalMl: data['goalMl'] ?? 2500,
      entries: (data['entries'] as List<dynamic>?)
              ?.map((e) => WaterEntry.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  WaterLogModel copyWith({int? totalMl, List<WaterEntry>? entries}) {
    return WaterLogModel(
      id: id,
      date: date,
      totalMl: totalMl ?? this.totalMl,
      goalMl: goalMl,
      entries: entries ?? this.entries,
    );
  }
}

/// A single water intake entry.
class WaterEntry {
  final int amountMl;
  final DateTime time;

  const WaterEntry({
    required this.amountMl,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'amountMl': amountMl,
      'time': Timestamp.fromDate(time),
    };
  }

  factory WaterEntry.fromMap(Map<String, dynamic> map) {
    return WaterEntry(
      amountMl: map['amountMl'] ?? 0,
      time: (map['time'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
