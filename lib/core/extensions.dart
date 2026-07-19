import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Context extensions for easy access to theme data.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Show a themed snackbar.
  void showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// DateTime extensions.
extension DateTimeX on DateTime {
  /// Format as "Jul 18, 2026"
  String get formatted => DateFormat('MMM d, yyyy').format(this);

  /// Format as "July 18"
  String get shortFormatted => DateFormat('MMMM d').format(this);

  /// Format as "Mon"
  String get dayName => DateFormat('E').format(this);

  /// Format as "Monday"
  String get fullDayName => DateFormat('EEEE').format(this);

  /// Format as "7:30 AM"
  String get timeFormatted => DateFormat('h:mm a').format(this);

  /// Check if same day as another date.
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Check if today.
  bool get isToday => isSameDay(DateTime.now());

  /// Get start of day (midnight).
  DateTime get startOfDay => DateTime(year, month, day);
}

/// Number formatting extensions.
extension NumX on num {
  /// Format as "1,234"
  String get formatted => NumberFormat('#,##0').format(this);

  /// Format as "1.2k"
  String get compact => NumberFormat.compact().format(this);

  /// Format as "1,234 kcal"
  String get kcal => '${formatted} kcal';

  /// Format as "1,234 steps"
  String get steps => '${formatted} steps';

  /// Format as "1.2 km"
  String get km => '${toStringAsFixed(1)} km';

  /// Format as "45 min"
  String get mins => '${toInt()} min';
}

/// String extensions.
extension StringX on String {
  /// Capitalize first letter.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Get initials from name (e.g., "John Doe" -> "JD").
  String get initials {
    final parts = trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return isNotEmpty ? this[0].toUpperCase() : '?';
  }
}
