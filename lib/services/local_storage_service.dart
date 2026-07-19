import 'package:shared_preferences/shared_preferences.dart';

/// Local storage service using SharedPreferences for offline caching.
class LocalStorageService {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── Theme ───
  static bool get isDarkMode => _prefs?.getBool('isDarkMode') ?? true;
  static Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool('isDarkMode', value);
  }

  // ─── User ───
  static String? get userId => _prefs?.getString('userId');
  static Future<void> setUserId(String? value) async {
    if (value == null) {
      await _prefs?.remove('userId');
    } else {
      await _prefs?.setString('userId', value);
    }
  }

  // ─── Goals ───
  static int get stepGoal => _prefs?.getInt('stepGoal') ?? 10000;
  static Future<void> setStepGoal(int value) async {
    await _prefs?.setInt('stepGoal', value);
  }

  static int get waterGoal => _prefs?.getInt('waterGoal') ?? 2500;
  static Future<void> setWaterGoal(int value) async {
    await _prefs?.setInt('waterGoal', value);
  }

  static int get calorieGoal => _prefs?.getInt('calorieGoal') ?? 500;
  static Future<void> setCalorieGoal(int value) async {
    await _prefs?.setInt('calorieGoal', value);
  }

  // ─── Onboarding ───
  static bool get hasSeenOnboarding =>
      _prefs?.getBool('hasSeenOnboarding') ?? false;
  static Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs?.setBool('hasSeenOnboarding', value);
  }

  // ─── Notifications ───
  static bool get notificationsEnabled =>
      _prefs?.getBool('notificationsEnabled') ?? true;
  static Future<void> setNotificationsEnabled(bool value) async {
    await _prefs?.setBool('notificationsEnabled', value);
  }

  // ─── Units ───
  static bool get useMetric => _prefs?.getBool('useMetric') ?? true;
  static Future<void> setUseMetric(bool value) async {
    await _prefs?.setBool('useMetric', value);
  }

  /// Clear all stored data.
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
