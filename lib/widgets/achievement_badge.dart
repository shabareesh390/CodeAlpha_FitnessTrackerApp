import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated achievement badge widget.
class AchievementBadge extends StatelessWidget {
  final String emoji;
  final String title;
  final bool isUnlocked;

  const AchievementBadge({
    Key? key,
    required this.emoji,
    required this.title,
    this.isUnlocked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isUnlocked
                ? AppColors.primary.withValues(alpha: 0.15)
                : AppColors.cardDark,
            border: Border.all(
              color: isUnlocked
                  ? AppColors.primary
                  : AppColors.glassBorder,
              width: 2,
            ),
            boxShadow: isUnlocked
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(
                fontSize: 24,
                color: isUnlocked ? null : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 64,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isUnlocked
                  ? AppColors.textSecondaryDark
                  : AppColors.textTertiaryDark,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
