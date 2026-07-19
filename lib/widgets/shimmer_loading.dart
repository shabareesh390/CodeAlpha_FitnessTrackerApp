import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Shimmer skeleton loading placeholder.
class ShimmerLoading extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    Key? key,
    this.width,
    this.height = 100,
    this.borderRadius = AppSpacing.radiusLg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardDark,
      highlightColor: AppColors.cardDarkElevated,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  /// Creates a full dashboard skeleton layout.
  static Widget dashboardSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting skeleton
          const ShimmerLoading(width: 200, height: 24),
          const SizedBox(height: 8),
          const ShimmerLoading(width: 280, height: 16),
          const SizedBox(height: 32),

          // Progress ring skeleton
          const Center(child: ShimmerLoading(width: 200, height: 200, borderRadius: 100)),
          const SizedBox(height: 32),

          // Metric cards grid skeleton
          Row(
            children: const [
              Expanded(child: ShimmerLoading(height: 120)),
              SizedBox(width: 12),
              Expanded(child: ShimmerLoading(height: 120)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: ShimmerLoading(height: 120)),
              SizedBox(width: 12),
              Expanded(child: ShimmerLoading(height: 120)),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates a workout list skeleton.
  static Widget workoutListSkeleton() {
    return Column(
      children: List.generate(
        3,
        (i) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: ShimmerLoading(height: 200),
        ),
      ),
    );
  }
}
