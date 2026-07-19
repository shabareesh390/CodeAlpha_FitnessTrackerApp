import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/workout_model.dart';
import '../models/activity_model.dart';
import '../models/water_log_model.dart';
import '../models/daily_stats_model.dart';

/// Centralized Firestore data access service.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ═══════════════════════════════════════════
  //  USER
  // ═══════════════════════════════════════════

  /// Get user profile.
  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  /// Update user profile.
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).set(data, SetOptions(merge: true));
  }

  /// Stream user profile changes.
  Stream<UserModel?> streamUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    });
  }

  // ═══════════════════════════════════════════
  //  WORKOUTS
  // ═══════════════════════════════════════════

  /// Get all workouts for a user.
  Future<List<WorkoutModel>> getWorkouts(String uid) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .orderBy('title')
        .get();
    return snapshot.docs
        .map((doc) => WorkoutModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  /// Add a workout.
  Future<void> addWorkout(String uid, WorkoutModel workout) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .doc(workout.id)
        .set(workout.toFirestore());
  }

  /// Update workout favorite status.
  Future<void> toggleWorkoutFavorite(
    String uid,
    String workoutId,
    bool isFavorite,
  ) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .doc(workoutId)
        .update({'isFavorite': isFavorite});
  }

  // ═══════════════════════════════════════════
  //  ACTIVITIES
  // ═══════════════════════════════════════════

  /// Get activity for a specific date.
  Future<ActivityModel?> getActivity(String uid, DateTime date) async {
    final dateKey = _dateKey(date);
    final doc = await _db
        .collection('users')
        .doc(uid)
        .collection('activities')
        .doc(dateKey)
        .get();
    if (!doc.exists) return null;
    return ActivityModel.fromFirestore(doc.data()!, doc.id);
  }

  /// Get activities for a date range.
  Future<List<ActivityModel>> getActivities(
    String uid,
    DateTime start,
    DateTime end,
  ) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('activities')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date')
        .get();
    return snapshot.docs
        .map((doc) => ActivityModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  /// Save activity data.
  Future<void> saveActivity(String uid, ActivityModel activity) async {
    final dateKey = _dateKey(activity.date);
    await _db
        .collection('users')
        .doc(uid)
        .collection('activities')
        .doc(dateKey)
        .set(activity.toFirestore(), SetOptions(merge: true));
  }

  // ═══════════════════════════════════════════
  //  WATER LOGS
  // ═══════════════════════════════════════════

  /// Get water log for a specific date.
  Future<WaterLogModel?> getWaterLog(String uid, DateTime date) async {
    final dateKey = _dateKey(date);
    final doc = await _db
        .collection('users')
        .doc(uid)
        .collection('water_logs')
        .doc(dateKey)
        .get();
    if (!doc.exists) return null;
    return WaterLogModel.fromFirestore(doc.data()!, doc.id);
  }

  /// Save water log.
  Future<void> saveWaterLog(String uid, WaterLogModel log) async {
    final dateKey = _dateKey(log.date);
    await _db
        .collection('users')
        .doc(uid)
        .collection('water_logs')
        .doc(dateKey)
        .set(log.toFirestore());
  }

  /// Get water logs for a date range.
  Future<List<WaterLogModel>> getWaterLogs(
    String uid,
    DateTime start,
    DateTime end,
  ) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('water_logs')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date')
        .get();
    return snapshot.docs
        .map((doc) => WaterLogModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // ═══════════════════════════════════════════
  //  DAILY STATS
  // ═══════════════════════════════════════════

  /// Get daily stats.
  Future<DailyStatsModel?> getDailyStats(String uid, DateTime date) async {
    final dateKey = _dateKey(date);
    final doc = await _db
        .collection('users')
        .doc(uid)
        .collection('daily_stats')
        .doc(dateKey)
        .get();
    if (!doc.exists) return null;
    return DailyStatsModel.fromFirestore(doc.data()!, doc.id);
  }

  /// Save daily stats.
  Future<void> saveDailyStats(String uid, DailyStatsModel stats) async {
    final dateKey = _dateKey(stats.date);
    await _db
        .collection('users')
        .doc(uid)
        .collection('daily_stats')
        .doc(dateKey)
        .set(stats.toFirestore(), SetOptions(merge: true));
  }

  /// Get daily stats for a date range.
  Future<List<DailyStatsModel>> getDailyStatsRange(
    String uid,
    DateTime start,
    DateTime end,
  ) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('daily_stats')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date')
        .get();
    return snapshot.docs
        .map((doc) => DailyStatsModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // ─── Helpers ───
  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
