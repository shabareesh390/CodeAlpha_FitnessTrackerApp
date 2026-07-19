import 'dart:math';
import '../models/workout_model.dart';
import '../models/activity_model.dart';
import '../models/daily_stats_model.dart';
import '../models/water_log_model.dart';
import '../core/enums.dart';

/// Generates realistic mock data for the app demo.
/// Used when Firestore has no data yet.
class MockDataService {
  static final _random = Random();

  /// Generate today's daily stats with realistic values.
  static DailyStatsModel generateTodayStats() {
    return DailyStatsModel(
      id: 'today',
      date: DateTime.now(),
      steps: 4000 + _random.nextInt(6000),
      caloriesBurned: 150 + _random.nextInt(350),
      activeMinutes: 10 + _random.nextInt(50),
      workoutDuration: _random.nextInt(60),
      waterIntake: 500 + _random.nextInt(2000),
      sleepDuration: 5.5 + _random.nextDouble() * 3.0,
      heartRate: 60 + _random.nextInt(30),
      weight: 70.0 + _random.nextDouble() * 5,
    );
  }

  /// Generate weekly activity data for charts.
  static List<ActivityModel> generateWeeklyActivities() {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final date = now.subtract(Duration(days: 6 - i));
      return ActivityModel(
        id: 'activity_$i',
        date: date,
        steps: 3000 + _random.nextInt(10000),
        distance: 2.0 + _random.nextDouble() * 8.0,
        calories: 100 + _random.nextInt(500),
        floors: _random.nextInt(20),
        activeMinutes: 10 + _random.nextInt(80),
        heartRate: 60 + _random.nextInt(35),
      );
    });
  }

  /// Generate weekly daily stats for charts.
  static List<DailyStatsModel> generateWeeklyStats() {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final date = now.subtract(Duration(days: 6 - i));
      return DailyStatsModel(
        id: 'stats_$i',
        date: date,
        steps: 3000 + _random.nextInt(10000),
        caloriesBurned: 100 + _random.nextInt(500),
        activeMinutes: 10 + _random.nextInt(80),
        workoutDuration: _random.nextInt(90),
        waterIntake: 500 + _random.nextInt(2500),
        sleepDuration: 5.0 + _random.nextDouble() * 4.0,
        heartRate: 60 + _random.nextInt(30),
        weight: 70.0 + _random.nextDouble() * 2 - 1,
      );
    });
  }

  /// Generate monthly stats.
  static List<DailyStatsModel> generateMonthlyStats() {
    final now = DateTime.now();
    return List.generate(30, (i) {
      final date = now.subtract(Duration(days: 29 - i));
      return DailyStatsModel(
        id: 'stats_m_$i',
        date: date,
        steps: 3000 + _random.nextInt(10000),
        caloriesBurned: 100 + _random.nextInt(500),
        activeMinutes: 10 + _random.nextInt(80),
        workoutDuration: _random.nextInt(90),
        waterIntake: 500 + _random.nextInt(2500),
        sleepDuration: 5.0 + _random.nextDouble() * 4.0,
        heartRate: 60 + _random.nextInt(30),
        weight: 70.5 - (i * 0.05) + _random.nextDouble() * 0.5,
      );
    });
  }

  /// Generate sample workouts.
  static List<WorkoutModel> generateWorkouts() {
    return [
      const WorkoutModel(
        id: 'w1',
        title: 'Full Body Burn',
        category: WorkoutCategory.hiit,
        durationMinutes: 30,
        estimatedCalories: 350,
        difficulty: WorkoutDifficulty.intermediate,
        description:
            'High-intensity interval training targeting all major muscle groups. Perfect for burning fat and building lean muscle.',
        targetMuscles: ['Full Body', 'Core', 'Legs', 'Arms'],
        equipment: ['Dumbbells', 'Mat'],
      ),
      const WorkoutModel(
        id: 'w2',
        title: 'Morning Yoga Flow',
        category: WorkoutCategory.yoga,
        durationMinutes: 25,
        estimatedCalories: 120,
        difficulty: WorkoutDifficulty.beginner,
        description:
            'Start your day with a gentle yoga flow that stretches and awakens your body. Focus on breathing and flexibility.',
        targetMuscles: ['Full Body', 'Core', 'Back'],
        equipment: ['Yoga Mat'],
      ),
      const WorkoutModel(
        id: 'w3',
        title: 'Power Chest & Triceps',
        category: WorkoutCategory.strength,
        durationMinutes: 45,
        estimatedCalories: 280,
        difficulty: WorkoutDifficulty.advanced,
        description:
            'Build upper body strength with compound chest and tricep exercises. Progressive overload approach.',
        targetMuscles: ['Chest', 'Triceps', 'Shoulders'],
        equipment: ['Barbell', 'Bench', 'Dumbbells'],
      ),
      const WorkoutModel(
        id: 'w4',
        title: '5K Run Training',
        category: WorkoutCategory.running,
        durationMinutes: 35,
        estimatedCalories: 400,
        difficulty: WorkoutDifficulty.intermediate,
        description:
            'Interval-based running program to improve your 5K time. Alternates between speed and recovery.',
        targetMuscles: ['Legs', 'Core', 'Cardio'],
        equipment: ['Running Shoes'],
      ),
      const WorkoutModel(
        id: 'w5',
        title: 'Indoor Cycling Sprint',
        category: WorkoutCategory.cycling,
        durationMinutes: 40,
        estimatedCalories: 450,
        difficulty: WorkoutDifficulty.advanced,
        description:
            'High-energy indoor cycling session with sprint intervals and hill climbs. Great for cardio endurance.',
        targetMuscles: ['Legs', 'Glutes', 'Core'],
        equipment: ['Stationary Bike'],
      ),
      const WorkoutModel(
        id: 'w6',
        title: 'Core Crusher',
        category: WorkoutCategory.strength,
        durationMinutes: 20,
        estimatedCalories: 180,
        difficulty: WorkoutDifficulty.beginner,
        description:
            'Focused core workout targeting abs, obliques, and lower back. No equipment needed.',
        targetMuscles: ['Abs', 'Obliques', 'Lower Back'],
        equipment: ['Mat'],
      ),
      const WorkoutModel(
        id: 'w7',
        title: 'Cardio Dance Party',
        category: WorkoutCategory.cardio,
        durationMinutes: 30,
        estimatedCalories: 320,
        difficulty: WorkoutDifficulty.beginner,
        description:
            'Fun dance-based cardio workout. Easy to follow choreography that gets your heart pumping.',
        targetMuscles: ['Full Body', 'Legs', 'Core'],
        equipment: ['None'],
      ),
      const WorkoutModel(
        id: 'w8',
        title: 'Recovery Stretch',
        category: WorkoutCategory.stretching,
        durationMinutes: 15,
        estimatedCalories: 50,
        difficulty: WorkoutDifficulty.beginner,
        description:
            'Gentle stretching routine for post-workout recovery. Helps reduce soreness and improve flexibility.',
        targetMuscles: ['Full Body', 'Hamstrings', 'Shoulders'],
        equipment: ['Mat', 'Foam Roller'],
      ),
      const WorkoutModel(
        id: 'w9',
        title: 'Tabata Thunder',
        category: WorkoutCategory.hiit,
        durationMinutes: 20,
        estimatedCalories: 300,
        difficulty: WorkoutDifficulty.advanced,
        description:
            '20 seconds on, 10 seconds off Tabata protocol. Maximum intensity for maximum results.',
        targetMuscles: ['Full Body', 'Core', 'Legs'],
        equipment: ['None'],
      ),
      const WorkoutModel(
        id: 'w10',
        title: 'Leg Day Destroyer',
        category: WorkoutCategory.strength,
        durationMinutes: 50,
        estimatedCalories: 380,
        difficulty: WorkoutDifficulty.intermediate,
        description:
            'Comprehensive leg workout hitting quads, hamstrings, glutes, and calves. Build serious lower body strength.',
        targetMuscles: ['Quads', 'Hamstrings', 'Glutes', 'Calves'],
        equipment: ['Barbell', 'Squat Rack', 'Dumbbells'],
      ),
    ];
  }

  /// Generate today's water log.
  static WaterLogModel generateTodayWaterLog() {
    final entryCount = 2 + _random.nextInt(4);
    int total = 0;
    final entries = List.generate(entryCount, (i) {
      final amount = (1 + _random.nextInt(3)) * 250;
      total += amount;
      return WaterEntry(
        amountMl: amount,
        time: DateTime.now().subtract(Duration(hours: entryCount - i)),
      );
    });
    return WaterLogModel(
      id: 'today',
      date: DateTime.now(),
      totalMl: total,
      goalMl: 2500,
      entries: entries,
    );
  }
}
