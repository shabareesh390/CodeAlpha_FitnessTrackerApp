import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../providers/water_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/water_bottle.dart';
import '../../widgets/glass_card.dart';
import '../../animations/fade_animation.dart';
import '../../animations/scale_animation.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  void _toggleMeal(BuildContext context, String mealType, int calories) {
    final dashboardProvider = context.read<DashboardProvider>();
    final todayStats = dashboardProvider.todayStats;
    if (todayStats == null) return;

    final isLogged = todayStats.mealsLogged.contains(mealType);
    final newMeals = List<String>.from(todayStats.mealsLogged);
    int newCaloriesConsumed = todayStats.caloriesConsumed;

    if (isLogged) {
      newMeals.remove(mealType);
      newCaloriesConsumed -= calories;
    } else {
      newMeals.add(mealType);
      newCaloriesConsumed += calories;
    }

    dashboardProvider.updateTodayStats(todayStats.copyWith(
      mealsLogged: newMeals,
      caloriesConsumed: newCaloriesConsumed.clamp(0, 99999),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final calorieGoal = context.watch<ProfileProvider>().user?.calorieGoal ?? 2000;
    final todayStats = context.watch<DashboardProvider>().todayStats;
    
    final _consumedCalories = todayStats?.caloriesConsumed ?? 0;
    final _breakfastLogged = todayStats?.mealsLogged.contains('Breakfast') ?? false;
    final _lunchLogged = todayStats?.mealsLogged.contains('Lunch') ?? false;
    final _dinnerLogged = todayStats?.mealsLogged.contains('Dinner') ?? false;

    final remainingCalories = (calorieGoal - _consumedCalories).clamp(0, calorieGoal);
    final progress = calorieGoal > 0 ? _consumedCalories / calorieGoal : 0.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeAnimation(
                child: Text(
                  'Nutrition & Hydration',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Macro Summary
              FadeAnimation(
                delay: const Duration(milliseconds: 100),
                child: GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Calories Remaining',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: AppColors.textSecondaryDark,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$remainingCalories',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                              color: AppColors.primary,
                              strokeWidth: 6,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMacroTracker('Carbs', progress * 0.9, AppColors.secondary, '${(_consumedCalories * 0.4 / 4).toInt()}/${(calorieGoal * 0.4 / 4).toInt()}g'),
                          _buildMacroTracker('Protein', progress * 1.1, AppColors.calories, '${(_consumedCalories * 0.3 / 4).toInt()}/${(calorieGoal * 0.3 / 4).toInt()}g'),
                          _buildMacroTracker('Fat', progress * 0.8, AppColors.warning, '${(_consumedCalories * 0.3 / 9).toInt()}/${(calorieGoal * 0.3 / 9).toInt()}g'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Meal Logging
              FadeAnimation(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Today\'s Meals',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FadeAnimation(
                delay: const Duration(milliseconds: 250),
                child: GestureDetector(
                  onTap: () => _toggleMeal(context, 'Breakfast', 450),
                  child: _buildMealCard(context, 'Breakfast', '450 kcal', Icons.breakfast_dining, isLogged: _breakfastLogged),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FadeAnimation(
                delay: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () => _toggleMeal(context, 'Lunch', 650),
                  child: _buildMealCard(context, 'Lunch', '650 kcal', Icons.lunch_dining, isLogged: _lunchLogged),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FadeAnimation(
                delay: const Duration(milliseconds: 350),
                child: GestureDetector(
                  onTap: () => _toggleMeal(context, 'Dinner', 550),
                  child: _buildMealCard(context, 'Dinner', '550 kcal', Icons.dinner_dining, isLogged: _dinnerLogged),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Water Tracker
              FadeAnimation(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  'Hydration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FadeAnimation(
                delay: const Duration(milliseconds: 450),
                child: GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Consumer<WaterProvider>(
                    builder: (context, waterProvider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Minus Button
                          ScaleAnimation(
                            child: IconButton(
                              icon: const Icon(Icons.remove_circle_outline, size: 36, color: AppColors.textSecondaryDark),
                              onPressed: () => waterProvider.removeWater(250),
                            ),
                          ),
                          // Water Bottle
                          Column(
                            children: [
                              WaterBottle(
                                progress: (waterProvider.totalMl / (context.watch<ProfileProvider>().user?.waterGoal ?? 2500)).clamp(0.0, 1.0),
                                width: 100,
                                height: 180,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                '${waterProvider.totalMl} / ${context.watch<ProfileProvider>().user?.waterGoal ?? 2500} ml',
                                style: const TextStyle(
                                  color: AppColors.textPrimaryDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // Plus Button
                          ScaleAnimation(
                            child: IconButton(
                              icon: const Icon(Icons.add_circle, size: 36, color: AppColors.water),
                              onPressed: () => waterProvider.addWater(250),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroTracker(String title, double progress, Color color, String value) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(color.withValues(alpha: 0.1)),
              ),
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeCap: StrokeCap.round,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textTertiaryDark,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMealCard(BuildContext context, String title, String subtitle, IconData icon, {bool isLogged = true}) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isLogged ? AppColors.success.withValues(alpha: 0.15) : AppColors.surfaceDark,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isLogged ? AppColors.success : AppColors.textSecondaryDark,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isLogged ? AppColors.primary : AppColors.textTertiaryDark,
                        fontWeight: isLogged ? FontWeight.w600 : FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            isLogged ? Icons.check_circle : Icons.add_circle_outline,
            color: isLogged ? AppColors.success : AppColors.primary,
          ),
        ],
      ),
    );
  }
}
