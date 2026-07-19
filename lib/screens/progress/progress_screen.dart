import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../providers/activity_provider.dart';
import '../../widgets/custom_chart.dart';
import '../../widgets/achievement_badge.dart';
import '../../widgets/glass_card.dart';
import '../../animations/fade_animation.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activityProvider = context.watch<ActivityProvider>();
    final weeklyStats = activityProvider.weeklyStats;
    
    // Sort chronologically just in case, or assume they are ordered
    // Create data arrays, pad with 0 if fewer than 7 days
    final calorieData = List.generate(7, (i) {
      if (i < weeklyStats.length) return weeklyStats[i].caloriesBurned.toDouble();
      return 0.0;
    });
    
    final activeMinutesData = List.generate(7, (i) {
      if (i < weeklyStats.length) return weeklyStats[i].activeMinutes.toDouble();
      return 0.0;
    });

    final xLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeAnimation(
                child: Text(
                  'Progress',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Bar Chart - Calories
              FadeAnimation(
                delay: const Duration(milliseconds: 100),
                child: _buildChartSection(
                  context: context,
                  title: 'Calories Burned',
                  subtitle: 'Last 7 Days',
                  icon: Icons.local_fire_department,
                  color: AppColors.calories,
                  chart: CustomChart(
                    type: ChartType.bar,
                    data: calorieData,
                    xLabels: xLabels,
                    color: AppColors.calories,
                    maxY: 3000,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Line Chart - Active Minutes
              FadeAnimation(
                delay: const Duration(milliseconds: 200),
                child: _buildChartSection(
                  context: context,
                  title: 'Active Minutes',
                  subtitle: 'Last 7 Days',
                  icon: Icons.timer,
                  color: AppColors.activeMinutes,
                  chart: CustomChart(
                    type: ChartType.line,
                    data: activeMinutesData,
                    xLabels: xLabels,
                    color: AppColors.activeMinutes,
                    maxY: 100,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Achievements
              FadeAnimation(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Achievements',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryDark,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          AchievementBadge(emoji: '🔥', title: '7 Day Streak', isUnlocked: true),
                          SizedBox(width: AppSpacing.lg),
                          AchievementBadge(emoji: '🏋️', title: '30 Workouts', isUnlocked: true),
                          SizedBox(width: AppSpacing.lg),
                          AchievementBadge(emoji: '🏃', title: 'Marathon', isUnlocked: false),
                          SizedBox(width: AppSpacing.lg),
                          AchievementBadge(emoji: '💧', title: 'Hydrated', isUnlocked: true),
                          SizedBox(width: AppSpacing.lg),
                          AchievementBadge(emoji: '👟', title: '10k Steps', isUnlocked: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget chart,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryDark,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          SizedBox(
            height: 200,
            child: chart,
          ),
        ],
      ),
    );
  }
}
