import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/metric_card.dart';
import '../../widgets/progress_ring.dart';
import '../../widgets/glass_card.dart';
import '../../animations/fade_animation.dart';
import '../../animations/scale_animation.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/dashboard_provider.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final photoUrl = user?.photoURL;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header ───
              FadeAnimation(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HELLO 👋',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textTertiaryDark,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Ready to crush today's goals?",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimaryDark,
                              ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.surfaceDark,
                      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                      child: photoUrl == null ? const Icon(Icons.person, color: AppColors.textSecondaryDark) : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // ─── Daily Goal Ring ───
              FadeAnimation(
                delay: const Duration(milliseconds: 100),
                child: Center(
                  child: ScaleAnimation(
                    child: ProgressRing(
                      progress: (context.watch<ProfileProvider>().user?.calorieGoal ?? 2000) > 0 
                                ? (context.watch<DashboardProvider>().todayStats?.caloriesBurned ?? 0) / (context.watch<ProfileProvider>().user?.calorieGoal ?? 2000)
                                : 0.0,
                      size: 220,
                      strokeWidth: 16,
                      progressColor: AppColors.primary,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: AppColors.calories,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${context.watch<DashboardProvider>().todayStats?.caloriesBurned ?? 0}',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimaryDark,
                                  height: 1,
                                ),
                          ),
                          Text(
                            '/ ${context.watch<ProfileProvider>().user?.calorieGoal ?? 2000} kcal',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textTertiaryDark,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // ─── Quick Actions ───
              FadeAnimation(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildQuickAction(
                        context,
                        'Workout',
                        Icons.fitness_center_rounded,
                        AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _buildQuickAction(
                        context,
                        'Meal',
                        Icons.restaurant_rounded,
                        AppColors.calories,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _buildQuickAction(
                        context,
                        'Water',
                        Icons.water_drop_rounded,
                        AppColors.water,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // ─── Metrics Grid ───
              FadeAnimation(
                delay: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Activity',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryDark,
                          ),
                    ),
                    Icon(Icons.more_horiz, color: AppColors.textTertiaryDark),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              FadeAnimation(
                delay: const Duration(milliseconds: 400),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppSpacing.lg,
                  mainAxisSpacing: AppSpacing.lg,
                  childAspectRatio: 0.9,
                  children: [
                    MetricCard(
                      icon: Icons.directions_walk_rounded,
                      value: '${context.watch<DashboardProvider>().todayStats?.steps ?? 0}',
                      label: 'Steps',
                      color: AppColors.steps,
                      trend: '+12%',
                    ),
                    MetricCard(
                      icon: Icons.timer_rounded,
                      value: '${context.watch<DashboardProvider>().todayStats?.activeMinutes ?? 0}m',
                      label: 'Active Time',
                      color: AppColors.activeMinutes,
                    ),
                    MetricCard(
                      icon: Icons.favorite_rounded,
                      value: '${context.watch<DashboardProvider>().todayStats?.heartRate ?? 72}',
                      label: 'Avg HR (bpm)',
                      color: AppColors.heartRate,
                    ),
                    MetricCard(
                      icon: Icons.nightlight_round,
                      value: '${(context.watch<DashboardProvider>().todayStats?.sleepDuration ?? 0).toStringAsFixed(1)}h',
                      label: 'Sleep',
                      color: AppColors.sleep,
                      trend: '+5%',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String label, IconData icon, Color color) {
    return GlassCard(
      onTap: () {},
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
