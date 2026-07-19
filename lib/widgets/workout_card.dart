import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../models/workout_model.dart';
import '../animations/scale_animation.dart';
import '../core/enums.dart';

/// Premium workout card with gradient overlay, category badge, and favorite toggle.
class WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const WorkoutCard({
    Key? key,
    required this.workout,
    this.onTap,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(color: AppColors.glassBorder, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          child: Stack(
            children: [
              // Background gradient based on category
              Container(
                decoration: BoxDecoration(
                  gradient: _categoryGradient,
                ),
              ),

              // Category emoji (large background)
              Positioned(
                right: -20,
                bottom: -20,
                child: Text(
                  workout.category.emoji,
                  style: TextStyle(
                    fontSize: 100,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: category badge + favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusRound),
                          ),
                          child: Text(
                            workout.category.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriteToggle,
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              workout.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: workout.isFavorite
                                  ? AppColors.error
                                  : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Title
                    Text(
                      workout.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Info row
                    Row(
                      children: [
                        _infoChip(
                            Icons.timer_outlined, '${workout.durationMinutes}m'),
                        const SizedBox(width: AppSpacing.md),
                        _infoChip(Icons.local_fire_department,
                            '${workout.estimatedCalories} kcal'),
                        const SizedBox(width: AppSpacing.md),
                        _infoChip(Icons.signal_cellular_alt,
                            workout.difficulty.label),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  LinearGradient get _categoryGradient {
    switch (workout.category) {
      case WorkoutCategory.strength:
        return const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFBF360C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case WorkoutCategory.cardio:
        return const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case WorkoutCategory.yoga:
        return const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF6200EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case WorkoutCategory.running:
        return const LinearGradient(
          colors: [Color(0xFF00BCD4), Color(0xFF00838F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case WorkoutCategory.cycling:
        return const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case WorkoutCategory.hiit:
        return const LinearGradient(
          colors: [Color(0xFFFF5722), Color(0xFFD84315)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case WorkoutCategory.stretching:
        return const LinearGradient(
          colors: [Color(0xFF26C6DA), Color(0xFF00ACC1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
