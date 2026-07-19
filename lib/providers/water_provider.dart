import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/water_log_model.dart';
import '../services/firestore_service.dart';

/// Manages water intake tracking.
class WaterProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final log = await _firestoreService.getWaterLog(user.uid, DateTime.now());
      if (log != null) {
        _todayLog = log;
      } else {
        _todayLog = WaterLogModel(
          id: 'water_${DateTime.now().millisecondsSinceEpoch}',
          date: DateTime.now(),
          totalMl: 0,
          goalMl: 2500, // Will be overridden by profile in UI, but good default
          entries: [],
        );
        await _firestoreService.saveWaterLog(user.uid, _todayLog!);
      }
    } catch (e) {
      debugPrint('Error loading water log: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Add water intake.
  Future<void> addWater(int amountMl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    
    if (_todayLog == null) {
      _todayLog = WaterLogModel(
        id: 'water_${DateTime.now().millisecondsSinceEpoch}',
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
    await _firestoreService.saveWaterLog(user.uid, _todayLog!);
  }

  /// Remove water intake.
  Future<void> removeWater(int amountMl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _todayLog == null) return;
    
    final newTotal = (_todayLog!.totalMl - amountMl).clamp(0, 99999);
    _todayLog = _todayLog!.copyWith(totalMl: newTotal);
    notifyListeners();
    await _firestoreService.saveWaterLog(user.uid, _todayLog!);
  }
}
