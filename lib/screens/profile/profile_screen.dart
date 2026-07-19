import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/glass_card.dart';
import '../../animations/fade_animation.dart';
import '../chat/ai_coach_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final authProvider = context.watch<AuthProvider>();
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeAnimation(
                child: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // User Info Card
              FadeAnimation(
                delay: const Duration(milliseconds: 100),
                child: GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/google.png'), // Placeholder
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryDark,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'john.doe@example.com',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondaryDark,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                              ),
                              child: const Text(
                                'Pro Member',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Body Stats
              FadeAnimation(
                delay: const Duration(milliseconds: 150),
                child: Row(
                  children: [
                    Expanded(child: _buildStatCard('Weight', '75 kg')),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: _buildStatCard('Height', '180 cm')),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: _buildStatCard('Age', '28')),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // AI Coach Banner
              FadeAnimation(
                delay: const Duration(milliseconds: 200),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AICoachScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.white, size: 32),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'AI Fitness Coach',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Get personalized advice and plans!',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Settings
              FadeAnimation(
                delay: const Duration(milliseconds: 250),
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryDark,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FadeAnimation(
                delay: const Duration(milliseconds: 300),
                child: GlassCard(
                  child: Column(
                    children: [
                      _buildSettingTile(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildSettingTile(
                        icon: Icons.track_changes,
                        title: 'Goals',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildSettingTile(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: const Icon(Icons.dark_mode_outlined, color: AppColors.textPrimaryDark),
                        title: const Text(
                          'Dark Mode',
                          style: TextStyle(color: AppColors.textPrimaryDark, fontWeight: FontWeight.w500),
                        ),
                        trailing: Switch(
                          value: isDark,
                          onChanged: (value) => themeProvider.toggleTheme(),
                          activeThumbColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Logout Button
              FadeAnimation(
                delay: const Duration(milliseconds: 350),
                child: GestureDetector(
                  onTap: () => authProvider.signOut(),
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: const Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textTertiaryDark,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimaryDark),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimaryDark, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textTertiaryDark, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.glassBorder, height: 1, indent: 16, endIndent: 16);
  }
}
