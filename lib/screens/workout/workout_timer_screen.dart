import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../models/workout_model.dart';
import '../../providers/workout_provider.dart';
import '../../widgets/progress_ring.dart';
import '../../animations/fade_animation.dart';
import '../../animations/scale_animation.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutTimerScreen({Key? key, required this.workout}) : super(key: key);

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<WorkoutProvider>();
      provider.startTimer(widget.workout.durationMinutes);
      _startTicker();
    });
  }

  void _startTicker() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final provider = context.read<WorkoutProvider>();
      provider.tickTimer();
      if (!provider.isTimerRunning) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds / 60).floor();
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkoutProvider>();
    final remainingSeconds = provider.totalTimerSeconds - provider.timerSeconds;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      provider.stopTimer();
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Active Workout',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 48), // Balance for close icon
                ],
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Workout Title
              FadeAnimation(
                child: Text(
                  widget.workout.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        letterSpacing: -0.5,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FadeAnimation(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Keep going, you can do this!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                ),
              ),
              
              const Spacer(),

              // Circular Timer
              ScaleAnimation(
                child: ProgressRing(
                  progress: provider.timerProgress,
                  size: 280,
                  strokeWidth: 20,
                  animationDuration: const Duration(milliseconds: 500),
                  progressColor: AppColors.secondary,
                  backgroundColor: AppColors.surfaceDark,
                  center: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(remainingSeconds),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.w200,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text(
                        'REMAINING',
                        style: TextStyle(
                          color: AppColors.textTertiaryDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Controls
              FadeAnimation(
                delay: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pause/Resume
                    _buildControlButton(
                      icon: provider.isTimerPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                      label: provider.isTimerPaused ? 'Resume' : 'Pause',
                      color: AppColors.surfaceDark,
                      iconColor: Colors.white,
                      onTap: () {
                        if (provider.isTimerPaused) {
                          provider.resumeTimer();
                        } else {
                          provider.pauseTimer();
                        }
                      },
                    ),
                    const SizedBox(width: AppSpacing.xxxl),
                    // Finish
                    _buildControlButton(
                      icon: Icons.stop_rounded,
                      label: 'Finish',
                      color: AppColors.error.withValues(alpha: 0.2),
                      iconColor: AppColors.error,
                      onTap: () {
                        provider.stopTimer();
                        Navigator.of(context).pop(); // Go back to details
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 36),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
