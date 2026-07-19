import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../core/enums.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/workout_card.dart';
import '../../animations/fade_animation.dart';
import 'workout_detail_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = context.watch<WorkoutProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            FadeAnimation(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Workouts',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimaryDark,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: AppColors.textPrimaryDark),
                      onPressed: () {
                        // Search functionality can be added later
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            FadeAnimation(
              delay: const Duration(milliseconds: 100),
              child: SizedBox(
                height: 50,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  scrollDirection: Axis.horizontal,
                  itemCount: WorkoutCategory.values.length + 1,
                  separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = workoutProvider.selectedCategory == null;
                      return CategoryChip(
                        label: 'All',
                        emoji: '🔥',
                        isSelected: isSelected,
                        onTap: () => workoutProvider.setCategory(null),
                      );
                    }
                    final category = WorkoutCategory.values[index - 1];
                    final isSelected = workoutProvider.selectedCategory == category;
                    return CategoryChip(
                      label: category.label,
                      emoji: category.emoji,
                      isSelected: isSelected,
                      onTap: () => workoutProvider.setCategory(category),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Workout List
            Expanded(
              child: workoutProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : workoutProvider.workouts.isEmpty
                      ? const Center(
                          child: Text(
                            'No workouts found.',
                            style: TextStyle(color: AppColors.textSecondaryDark),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg, 0, AppSpacing.lg, 100),
                          itemCount: workoutProvider.workouts.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: AppSpacing.lg),
                          itemBuilder: (context, index) {
                            final workout = workoutProvider.workouts[index];
                            return FadeAnimation(
                              delay: Duration(milliseconds: 200 + (index * 50)),
                              child: WorkoutCard(
                                workout: workout,
                                onFavoriteToggle: () =>
                                    workoutProvider.toggleFavorite(workout.id),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WorkoutDetailScreen(workout: workout),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
