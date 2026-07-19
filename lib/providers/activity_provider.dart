import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../models/daily_stats_model.dart';
import '../services/mock_data_service.dart';
import '../core/enums.dart';

/// Manages activity tracking data and chart data.
class ActivityProvider extends ChangeNotifier {
  List<ActivityModel> _weeklyActivities = [];
  List<DailyStatsModel> _weeklyStats = [];
  List<DailyStatsModel> _monthlyStats = [];
  TimePeriod _selectedPeriod = TimePeriod.weekly;
  bool _isLoading = true;

  List<ActivityModel> get weeklyActivities => _weeklyActivities;
  List<DailyStatsModel> get weeklyStats => _weeklyStats;
  List<DailyStatsModel> get monthlyStats => _monthlyStats;
  TimePeriod get selectedPeriod => _selectedPeriod;
  bool get isLoading => _isLoading;

  /// Get stats for current selected period.
  List<DailyStatsModel> get currentPeriodStats {
    switch (_selectedPeriod) {
      case TimePeriod.weekly:
        return _weeklyStats;
      case TimePeriod.monthly:
        return _monthlyStats;
      case TimePeriod.yearly:
        return _monthlyStats; // Reuse monthly for now
    }
  }

  ActivityProvider() {
    loadActivityData();
  }

  Future<void> loadActivityData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    _weeklyActivities = MockDataService.generateWeeklyActivities();
    _weeklyStats = MockDataService.generateWeeklyStats();
    _monthlyStats = MockDataService.generateMonthlyStats();

    _isLoading = false;
    notifyListeners();
  }

  void setTimePeriod(TimePeriod period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  /// Get total steps for the current period.
  int get totalSteps =>
      currentPeriodStats.fold(0, (sum, s) => sum + s.steps);

  /// Get total calories for the current period.
  int get totalCalories =>
      currentPeriodStats.fold(0, (sum, s) => sum + s.caloriesBurned);

  /// Get average heart rate for the current period.
  int get avgHeartRate {
    if (currentPeriodStats.isEmpty) return 72;
    return (currentPeriodStats.fold(0, (sum, s) => sum + s.heartRate) /
            currentPeriodStats.length)
        .round();
  }

  /// Get total active minutes for the current period.
  int get totalActiveMinutes =>
      currentPeriodStats.fold(0, (sum, s) => sum + s.activeMinutes);

  /// Get average sleep duration.
  double get avgSleep {
    if (currentPeriodStats.isEmpty) return 0;
    return currentPeriodStats.fold(0.0, (sum, s) => sum + s.sleepDuration) /
        currentPeriodStats.length;
  }
}
