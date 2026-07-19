import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/mock_data_service.dart';
import '../core/enums.dart';

/// Manages workout list, categories, favorites, timer state.
class WorkoutProvider extends ChangeNotifier {
  List<WorkoutModel> _workouts = [];
  WorkoutCategory? _selectedCategory;
  bool _isLoading = true;
  String _searchQuery = '';

  // Timer state
  bool _isTimerRunning = false;
  bool _isTimerPaused = false;
  int _timerSeconds = 0;
  int _totalTimerSeconds = 0;

  List<WorkoutModel> get workouts => _filteredWorkouts;
  List<WorkoutModel> get allWorkouts => _workouts;
  WorkoutCategory? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  // Timer getters
  bool get isTimerRunning => _isTimerRunning;
  bool get isTimerPaused => _isTimerPaused;
  int get timerSeconds => _timerSeconds;
  int get totalTimerSeconds => _totalTimerSeconds;
  double get timerProgress =>
      _totalTimerSeconds > 0 ? _timerSeconds / _totalTimerSeconds : 0.0;

  List<WorkoutModel> get _filteredWorkouts {
    var filtered = _workouts;

    if (_selectedCategory != null) {
      filtered =
          filtered.where((w) => w.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((w) =>
              w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              w.category.label
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  List<WorkoutModel> get favoriteWorkouts =>
      _workouts.where((w) => w.isFavorite).toList();

  WorkoutProvider() {
    loadWorkouts();
  }

  Future<void> loadWorkouts() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    _workouts = MockDataService.generateWorkouts();
    _isLoading = false;
    notifyListeners();
  }

  void setCategory(WorkoutCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(String workoutId) {
    final index = _workouts.indexWhere((w) => w.id == workoutId);
    if (index != -1) {
      _workouts[index] =
          _workouts[index].copyWith(isFavorite: !_workouts[index].isFavorite);
      notifyListeners();
    }
  }

  // ─── Timer Controls ───

  void startTimer(int durationMinutes) {
    _totalTimerSeconds = durationMinutes * 60;
    _timerSeconds = 0;
    _isTimerRunning = true;
    _isTimerPaused = false;
    notifyListeners();
  }

  void tickTimer() {
    if (_isTimerRunning && !_isTimerPaused) {
      _timerSeconds++;
      if (_timerSeconds >= _totalTimerSeconds) {
        _isTimerRunning = false;
      }
      notifyListeners();
    }
  }

  void pauseTimer() {
    _isTimerPaused = true;
    notifyListeners();
  }

  void resumeTimer() {
    _isTimerPaused = false;
    notifyListeners();
  }

  void stopTimer() {
    _isTimerRunning = false;
    _isTimerPaused = false;
    _timerSeconds = 0;
    notifyListeners();
  }

  /// Get workouts grouped by category.
  Map<WorkoutCategory, List<WorkoutModel>> get workoutsByCategory {
    final map = <WorkoutCategory, List<WorkoutModel>>{};
    for (final workout in _workouts) {
      map.putIfAbsent(workout.category, () => []).add(workout);
    }
    return map;
  }
}
