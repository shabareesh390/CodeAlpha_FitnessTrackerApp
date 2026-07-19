/// App-wide constants.
class AppConstants {
  AppConstants._();

  // ─── App Info ───
  static const String appName = 'FittPulse';
  static const String appTagline = 'Your Premium Fitness Companion';
  static const String appVersion = '1.0.0';

  // ─── Firestore Collections ───
  static const String usersCollection = 'users';
  static const String workoutsCollection = 'workouts';
  static const String activitiesCollection = 'activities';
  static const String waterLogsCollection = 'water_logs';
  static const String dailyStatsCollection = 'daily_stats';

  // ─── Default Goals ───
  static const int defaultStepGoal = 10000;
  static const int defaultCalorieGoal = 500;
  static const int defaultWaterGoal = 2500; // ml
  static const int defaultActiveMinutesGoal = 30;
  static const int defaultWorkoutDurationGoal = 60; // minutes
  static const double defaultSleepGoal = 8.0; // hours

  // ─── Animation Durations ───
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animMedium = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);
  static const Duration animVerySlow = Duration(milliseconds: 800);

  // ─── Motivational Quotes ───
  static const List<String> motivationalQuotes = [
    "The only bad workout is the one that didn't happen. 💪",
    "Your body can stand almost anything. It's your mind that you have to convince.",
    "Fitness is not about being better than someone else. It's about being better than you used to be.",
    "The pain you feel today will be the strength you feel tomorrow.",
    "Don't stop when you're tired. Stop when you're done. 🔥",
    "Sweat is fat crying. Keep going!",
    "A one hour workout is 4% of your day. No excuses.",
    "Strive for progress, not perfection.",
    "The secret of getting ahead is getting started.",
    "Train insane or remain the same. ⚡",
  ];

  // ─── Greeting Messages ───
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    if (hour < 21) return 'Good Evening';
    return 'Good Night';
  }

  static String getGreetingEmoji() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '☀️';
    if (hour < 17) return '🌤️';
    if (hour < 21) return '🌅';
    return '🌙';
  }
}
