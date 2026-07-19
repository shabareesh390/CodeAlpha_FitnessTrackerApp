import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/floating_bottom_nav.dart';
import 'dashboard/home_dashboard.dart';
import 'activity/activity_screen.dart';
import 'workout/workout_screen.dart';
import 'progress/progress_screen.dart';
import 'profile/profile_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeDashboard(),
    ActivityScreen(),
    WorkoutScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // The current screen
          _screens[_currentIndex],
          
          // Floating Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: FloatingBottomNav(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
