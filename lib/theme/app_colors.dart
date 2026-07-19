import 'package:flutter/material.dart';

/// Premium color palette for the Fitness Tracker app.
/// Inspired by Apple Fitness, WHOOP, and Nike Training Club.
class AppColors {
  AppColors._();

  // ─── Primary Palette ───
  static const Color primary = Color(0xFF22C55E);       // Emerald Green
  static const Color primaryLight = Color(0xFF4ADE80);
  static const Color primaryDark = Color(0xFF16A34A);

  // ─── Secondary Palette ───
  static const Color secondary = Color(0xFF3B82F6);      // Electric Blue
  static const Color secondaryLight = Color(0xFF60A5FA);
  static const Color secondaryDark = Color(0xFF2563EB);

  // ─── Background ───
  static const Color backgroundDark = Color(0xFF0D0D0D);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color cardDarkElevated = Color(0xFF252525);

  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);

  // ─── Text ───
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textTertiaryDark = Color(0xFF6B7280);

  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);

  // ─── Status ───
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFCA5A5);
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFF86EFAC);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFCD34D);
  static const Color info = Color(0xFF3B82F6);

  // ─── Gradients ───
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF22C55E), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF1E1E1E), Color(0xFF252525)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x0DFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── Metric Colors ───
  static const Color steps = Color(0xFF22C55E);
  static const Color calories = Color(0xFFF97316);
  static const Color heartRate = Color(0xFFEF4444);
  static const Color water = Color(0xFF3B82F6);
  static const Color sleep = Color(0xFF8B5CF6);
  static const Color workout = Color(0xFFF59E0B);
  static const Color weight = Color(0xFFEC4899);
  static const Color activeMinutes = Color(0xFF06B6D4);

  // ─── Glass Effect ───
  static Color glassWhite = Colors.white.withValues(alpha: 0.08);
  static Color glassBorder = Colors.white.withValues(alpha: 0.12);
  static Color glassHighlight = Colors.white.withValues(alpha: 0.15);

  // ─── Divider ───
  static const Color dividerDark = Color(0xFF2A2A2A);
  static const Color dividerLight = Color(0xFFE5E7EB);
}
