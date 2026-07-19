import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/glass_card.dart';
import '../../animations/fade_animation.dart';
import '../../animations/page_transitions.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

/// Premium login screen with glassmorphism and animations.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // ─── Logo ───
                  FadeAnimation(
                    child: Container(
                      width: 90,
                      height: 90,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/icons/app_icon.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ─── Title ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'FittPulse',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeAnimation(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Your Premium Fitness Companion',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ─── Error Message ───
                  if (authProvider.errorMessage != null)
                    FadeAnimation(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: AppColors.error, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                authProvider.errorMessage!,
                                style: const TextStyle(
                                  color: AppColors.error,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => authProvider.clearError(),
                              child: const Icon(Icons.close,
                                  color: AppColors.error, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // ─── Email Field ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 300),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        prefixIcon:
                            Icon(Icons.email_outlined, size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ─── Password Field ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 400),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: authProvider.obscurePassword,
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon:
                            const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: GestureDetector(
                          onTap: () => authProvider.togglePasswordVisibility(),
                          child: Icon(
                            authProvider.obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (v.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ─── Forgot Password ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 450),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransitions.slideRight(
                                const ForgotPasswordScreen()),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── Login Button ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 500),
                    child: GradientButton(
                      text: 'Sign In',
                      isLoading: authProvider.isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authProvider.signInWithEmail(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── OR Divider ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 550),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.dividerDark,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg),
                          child: Text(
                            'or continue with',
                            style: TextStyle(
                              color: AppColors.textTertiaryDark,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.dividerDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── Google Sign In ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 600),
                    child: GlassCard(
                      onTap: authProvider.isLoading
                          ? null
                          : () => authProvider.signInWithGoogle(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxl,
                        vertical: AppSpacing.lg,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 22,
                            width: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: AppColors.textPrimaryDark,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),

                  // ─── Sign Up Link ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 700),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: AppColors.textTertiaryDark,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransitions.slideRight(
                                  const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── Footer ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 750),
                    child: Text(
                      'By continuing, you agree to our Terms & Privacy Policy.',
                      style: TextStyle(
                        color: AppColors.textTertiaryDark,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
            ),
          ),
        ),
      ),
    );
  }
}
