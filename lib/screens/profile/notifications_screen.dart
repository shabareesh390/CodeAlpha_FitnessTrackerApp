import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/glass_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _workoutReminders = true;
  bool _hydrationReminders = true;
  bool _mealReminders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark.withValues(alpha: 0.9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Manage your push notifications and alerts.',
                style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              
              GlassCard(
                child: Column(
                  children: [
                    _buildToggleTile(
                      'Workout Reminders',
                      'Get reminded to hit your daily exercise goals',
                      _workoutReminders,
                      (val) => setState(() => _workoutReminders = val),
                    ),
                    const Divider(color: AppColors.dividerDark, height: 1),
                    _buildToggleTile(
                      'Hydration Alerts',
                      'Stay hydrated throughout the day',
                      _hydrationReminders,
                      (val) => setState(() => _hydrationReminders = val),
                    ),
                    const Divider(color: AppColors.dividerDark, height: 1),
                    _buildToggleTile(
                      'Meal Logging',
                      'Reminders to log your breakfast, lunch, and dinner',
                      _mealReminders,
                      (val) => setState(() => _mealReminders = val),
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

  Widget _buildToggleTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Material(
      color: Colors.transparent,
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: AppColors.textPrimaryDark, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textTertiaryDark, fontSize: 12)),
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      ),
    );
  }
}
