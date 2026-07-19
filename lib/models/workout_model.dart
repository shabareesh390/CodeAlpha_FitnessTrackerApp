import '../core/enums.dart';

/// Workout model representing a single workout template.
class WorkoutModel {
  final String id;
  final String title;
  final WorkoutCategory category;
  final int durationMinutes;
  final int estimatedCalories;
  final WorkoutDifficulty difficulty;
  final String description;
  final List<String> targetMuscles;
  final List<String> equipment;
  final String? imageUrl;
  final bool isFavorite;

  const WorkoutModel({
    required this.id,
    required this.title,
    required this.category,
    required this.durationMinutes,
    required this.estimatedCalories,
    required this.difficulty,
    this.description = '',
    this.targetMuscles = const [],
    this.equipment = const [],
    this.imageUrl,
    this.isFavorite = false,
  });

  WorkoutModel copyWith({bool? isFavorite}) {
    return WorkoutModel(
      id: id,
      title: title,
      category: category,
      durationMinutes: durationMinutes,
      estimatedCalories: estimatedCalories,
      difficulty: difficulty,
      description: description,
      targetMuscles: targetMuscles,
      equipment: equipment,
      imageUrl: imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'category': category.name,
      'durationMinutes': durationMinutes,
      'estimatedCalories': estimatedCalories,
      'difficulty': difficulty.name,
      'description': description,
      'targetMuscles': targetMuscles,
      'equipment': equipment,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  factory WorkoutModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return WorkoutModel(
      id: docId,
      title: data['title'] ?? '',
      category: WorkoutCategory.values.firstWhere(
        (e) => e.name == data['category'],
        orElse: () => WorkoutCategory.strength,
      ),
      durationMinutes: data['durationMinutes'] ?? 30,
      estimatedCalories: data['estimatedCalories'] ?? 200,
      difficulty: WorkoutDifficulty.values.firstWhere(
        (e) => e.name == data['difficulty'],
        orElse: () => WorkoutDifficulty.beginner,
      ),
      description: data['description'] ?? '',
      targetMuscles: List<String>.from(data['targetMuscles'] ?? []),
      equipment: List<String>.from(data['equipment'] ?? []),
      imageUrl: data['imageUrl'],
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  /// Difficulty color for UI display.
  String get difficultyLabel {
    switch (difficulty) {
      case WorkoutDifficulty.beginner:
        return '🟢 Beginner';
      case WorkoutDifficulty.intermediate:
        return '🟡 Intermediate';
      case WorkoutDifficulty.advanced:
        return '🔴 Advanced';
    }
  }
}
