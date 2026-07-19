import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/glass_card.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late double _calorieGoal;
  late double _waterGoal;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final profileProvider = context.read<ProfileProvider>();
    final user = profileProvider.user;
    
    _calorieGoal = (user?.calorieGoal ?? 2000).toDouble();
    _waterGoal = (user?.waterGoal ?? 2500).toDouble();
  }

  Future<void> _saveGoals() async {
    setState(() => _isLoading = true);
    try {
      await context.read<ProfileProvider>().updateProfile({
        'calorieGoal': _calorieGoal.toInt(),
        'waterGoal': _waterGoal.toInt(),
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Goals updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating goals: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
          'My Goals',
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
                'Set your daily targets to stay on track.',
                style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily Calories',
                          style: TextStyle(color: AppColors.textPrimaryDark, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${_calorieGoal.toInt()} kcal',
                          style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Slider(
                      value: _calorieGoal.clamp(500, 5000),
                      min: 500,
                      max: 5000,
                      divisions: 90,
                      activeColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          _calorieGoal = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily Hydration',
                          style: TextStyle(color: AppColors.textPrimaryDark, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${_waterGoal.toInt()} ml',
                          style: const TextStyle(color: AppColors.water, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Slider(
                      value: _waterGoal.clamp(500, 6000),
                      min: 500,
                      max: 6000,
                      divisions: 55,
                      activeColor: AppColors.water,
                      onChanged: (val) {
                        setState(() {
                          _waterGoal = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 60),
              GradientButton(
                text: 'Save Goals',
                isLoading: _isLoading,
                onPressed: _saveGoals,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
