import 'dart:math';
import 'package:flutter/material.dart';
import '../models/daily_stats_model.dart';
import '../services/mock_data_service.dart';
import '../core/constants.dart';

/// Dashboard state: today's stats, greeting, motivational quote.
class DashboardProvider extends ChangeNotifier {
  DailyStatsModel? _todayStats;
  bool _isLoading = true;
  String _greeting = '';
  String _greetingEmoji = '';
  String _motivationalQuote = '';

  DailyStatsModel? get todayStats => _todayStats;
  bool get isLoading => _isLoading;
  String get greeting => _greeting;
  String get greetingEmoji => _greetingEmoji;
  String get motivationalQuote => _motivationalQuote;

  DashboardProvider() {
    _updateGreeting();
    loadTodayStats();
  }

  void _updateGreeting() {
    _greeting = AppConstants.getGreeting();
    _greetingEmoji = AppConstants.getGreetingEmoji();
    _motivationalQuote = AppConstants.motivationalQuotes[
        Random().nextInt(AppConstants.motivationalQuotes.length)];
  }

  /// Load today's stats (from Firestore or mock data).
  Future<void> loadTodayStats() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay for smooth animation
    await Future.delayed(const Duration(milliseconds: 800));

    // Use mock data for now
    _todayStats = MockDataService.generateTodayStats();
    _isLoading = false;
    notifyListeners();
  }

  /// Refresh dashboard data.
  Future<void> refresh() async {
    _updateGreeting();
    await loadTodayStats();
  }

  /// Get step progress (0.0 - 1.0).
  double get stepProgress {
    if (_todayStats == null) return 0.0;
    return (_todayStats!.steps / AppConstants.defaultStepGoal).clamp(0.0, 1.0);
  }

  /// Get calorie progress (0.0 - 1.0).
  double get calorieProgress {
    if (_todayStats == null) return 0.0;
    return (_todayStats!.caloriesBurned / AppConstants.defaultCalorieGoal)
        .clamp(0.0, 1.0);
  }

  /// Get water progress (0.0 - 1.0).
  double get waterProgress {
    if (_todayStats == null) return 0.0;
    return (_todayStats!.waterIntake / AppConstants.defaultWaterGoal)
        .clamp(0.0, 1.0);
  }

  /// Get active minutes progress (0.0 - 1.0).
  double get activeMinutesProgress {
    if (_todayStats == null) return 0.0;
    return (_todayStats!.activeMinutes / AppConstants.defaultActiveMinutesGoal)
        .clamp(0.0, 1.0);
  }
}
