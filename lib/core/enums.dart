/// Workout category types.
enum WorkoutCategory {
  strength('Strength', '💪'),
  cardio('Cardio', '🏃'),
  yoga('Yoga', '🧘'),
  running('Running', '🏃‍♂️'),
  cycling('Cycling', '🚴'),
  hiit('HIIT', '⚡'),
  stretching('Stretching', '🤸');

  const WorkoutCategory(this.label, this.emoji);
  final String label;
  final String emoji;
}

/// Workout difficulty levels.
enum WorkoutDifficulty {
  beginner('Beginner'),
  intermediate('Intermediate'),
  advanced('Advanced');

  const WorkoutDifficulty(this.label);
  final String label;
}

/// Meal categories for nutrition tracking.
enum MealType {
  breakfast('Breakfast', '🌅'),
  lunch('Lunch', '☀️'),
  dinner('Dinner', '🌙'),
  snacks('Snacks', '🍎');

  const MealType(this.label, this.emoji);
  final String label;
  final String emoji;
}

/// Activity metric types.
enum ActivityMetric {
  steps('Steps', '👟'),
  distance('Distance', '📍'),
  calories('Calories', '🔥'),
  floors('Floors', '🏢'),
  cycling('Cycling', '🚴'),
  running('Running', '🏃'),
  walking('Walking', '🚶');

  const ActivityMetric(this.label, this.emoji);
  final String label;
  final String emoji;
}

/// Fitness goal types.
enum FitnessGoal {
  loseWeight('Lose Weight'),
  gainMuscle('Gain Muscle'),
  stayFit('Stay Fit'),
  buildEndurance('Build Endurance'),
  flexibility('Improve Flexibility');

  const FitnessGoal(this.label);
  final String label;
}

/// Gender options.
enum Gender {
  male('Male'),
  female('Female'),
  other('Other'),
  preferNotToSay('Prefer not to say');

  const Gender(this.label);
  final String label;
}

/// Chart time period.
enum TimePeriod {
  weekly('Weekly'),
  monthly('Monthly'),
  yearly('Yearly');

  const TimePeriod(this.label);
  final String label;
}
