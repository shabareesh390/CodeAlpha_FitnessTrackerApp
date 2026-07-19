import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../models/workout_model.dart';
import '../../widgets/gradient_button.dart';
import '../../animations/fade_animation.dart';
import 'workout_timer_screen.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutDetailScreen({Key? key, required this.workout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero Image / Video Placeholder
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: AppColors.backgroundDark,
                leading: IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Placeholder background
                      Container(
                        color: AppColors.surfaceDark,
                        child: Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 64,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      // Gradient overlay for text readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.backgroundDark.withValues(alpha: 0.8),
                              AppColors.backgroundDark,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Badge
                      FadeAnimation(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusRound),
                          ),
                          child: Text(
                            workout.category.label,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Title
                      FadeAnimation(
                        delay: const Duration(milliseconds: 100),
                        child: Text(
                          workout.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimaryDark,
                                letterSpacing: -0.5,
                              ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Quick Info Row
                      FadeAnimation(
                        delay: const Duration(milliseconds: 150),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoColumn(Icons.timer_outlined,
                                '${workout.durationMinutes} min'),
                            _buildInfoColumn(Icons.local_fire_department,
                                '${workout.estimatedCalories} kcal'),
                            _buildInfoColumn(Icons.signal_cellular_alt,
                                workout.difficulty.label),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxxl),

                      // Description
                      FadeAnimation(
                        delay: const Duration(milliseconds: 200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryDark,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              workout.description.isNotEmpty
                                  ? workout.description
                                  : 'Get ready to sweat! This premium workout is designed to push your limits and help you achieve your fitness goals. Follow along with the instructor and keep your form tight.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondaryDark,
                                    height: 1.5,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // Target Muscles
                      FadeAnimation(
                        delay: const Duration(milliseconds: 250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Target Muscles',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryDark,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (workout.targetMuscles.isNotEmpty
                                      ? workout.targetMuscles
                                      : ['Full Body', 'Core', 'Legs'])
                                  .map((muscle) => _buildPill(muscle))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // Equipment
                      FadeAnimation(
                        delay: const Duration(milliseconds: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Equipment Needed',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryDark,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (workout.equipment.isNotEmpty
                                      ? workout.equipment
                                      : ['Mat', 'Water Bottle', 'Towel'])
                                  .map((eq) => _buildPill(eq,
                                      color: AppColors.secondary))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 120), // Padding for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Fixed Bottom Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeAnimation(
              delay: const Duration(milliseconds: 400),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.backgroundDark,
                      AppColors.backgroundDark,
                      AppColors.backgroundDark.withValues(alpha: 0.0),
                    ],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: GradientButton(
                    text: 'Start Workout',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              WorkoutTimerScreen(workout: workout),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textPrimaryDark, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPill(String text, {Color color = AppColors.primary}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimaryDark,
          fontSize: 13,
        ),
      ),
    );
  }
}
