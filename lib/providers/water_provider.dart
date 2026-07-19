import 'package:flutter/material.dart';
import '../models/water_log_model.dart';
import '../services/mock_data_service.dart';

/// Manages water intake tracking.
class WaterProvider extends ChangeNotifier {
  WaterLogModel? _todayLog;
  List<WaterLogModel> _weeklyLogs = [];
  bool _isLoading = true;

  WaterLogModel? get todayLog => _todayLog;
  List<WaterLogModel> get weeklyLogs => _weeklyLogs;
  bool get isLoading => _isLoading;

  double get progress => _todayLog?.progress ?? 0.0;
  int get totalMl => _todayLog?.totalMl ?? 0;
  int get goalMl => _todayLog?.goalMl ?? 2500;
  int get remaining => _todayLog?.remaining ?? 2500;
  bool get isGoalReached => _todayLog?.isGoalReached ?? false;

  WaterProvider() {
    loadWaterData();
  }

  Future<void> loadWaterData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _todayLog = MockDataService.generateTodayWaterLog();
    _isLoading = false;
    notifyListeners();
  }

  /// Add water intake.
  void addWater(int amountMl) {
    if (_todayLog == null) {
      _todayLog = WaterLogModel(
        id: 'today',
        date: DateTime.now(),
        totalMl: amountMl,
        goalMl: 2500,
        entries: [
          WaterEntry(amountMl: amountMl, time: DateTime.now()),
        ],
      );
    } else {
      _todayLog = _todayLog!.copyWith(
        totalMl: _todayLog!.totalMl + amountMl,
        entries: [
          ..._todayLog!.entries,
          WaterEntry(amountMl: amountMl, time: DateTime.now()),
        ],
      );
    }
    notifyListeners();
  }

  /// Remove water intake.
  void removeWater(int amountMl) {
    if (_todayLog == null) return;
    final newTotal = (_todayLog!.totalMl - amountMl).clamp(0, 99999);
    _todayLog = _todayLog!.copyWith(totalMl: newTotal);
    notifyListeners();
  }
}
