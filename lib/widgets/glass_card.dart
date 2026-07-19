import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Frosted glass card with blur effect and subtle border.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final double blur;
  final VoidCallback? onTap;
  final LinearGradient? gradient;

  const GlassCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = AppSpacing.radiusXl,
    this.backgroundColor,
    this.blur = 10,
    this.onTap,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient ??
                    (isDark
                        ? AppColors.glassGradient
                        : LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.8),
                              Colors.white.withValues(alpha: 0.6),
                            ],
                          )),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: isDark ? AppColors.glassBorder : Colors.grey.shade200,
                  width: 1,
                ),
                color: backgroundColor ??
                    (isDark ? AppColors.glassWhite : Colors.white),
              ),
              padding: padding ??
                  const EdgeInsets.all(AppSpacing.lg),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
