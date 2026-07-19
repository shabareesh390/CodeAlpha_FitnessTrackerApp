import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gradient_button.dart';
import '../../animations/fade_animation.dart';

/// Premium registration screen.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ─── Back Button ───
                  FadeAnimation(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.cardDark,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            size: 18, color: AppColors.textPrimaryDark),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ─── Title ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeAnimation(
                    delay: const Duration(milliseconds: 150),
                    child: Text(
                      'Start your fitness journey today 🚀',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ─── Error ───
                  if (authProvider.errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        authProvider.errorMessage!,
                        style: const TextStyle(
                            color: AppColors.error, fontSize: 13),
                      ),
                    ),

                  // ─── Name Field ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 200),
                    child: TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline, size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ─── Email Field ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 250),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined, size: 20),
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
                    delay: const Duration(milliseconds: 300),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: authProvider.obscurePassword,
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              authProvider.togglePasswordVisibility(),
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
                          return 'Please enter a password';
                        }
                        if (v.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ─── Confirm Password ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 350),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: authProvider.obscureConfirmPassword,
                      style: const TextStyle(color: AppColors.textPrimaryDark),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon:
                            const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              authProvider.toggleConfirmPasswordVisibility(),
                          child: Icon(
                            authProvider.obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // ─── Terms Checkbox ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 400),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _agreedToTerms,
                            onChanged: (v) =>
                                setState(() => _agreedToTerms = v ?? false),
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: BorderSide(color: AppColors.glassBorder),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'I agree to the Terms of Service & Privacy Policy',
                            style: TextStyle(
                              color: AppColors.textSecondaryDark,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── Create Account Button ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 450),
                    child: GradientButton(
                      text: 'Create Account',
                      isLoading: authProvider.isLoading,
                      onPressed: _agreedToTerms
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                final success =
                                    await authProvider.signUpWithEmail(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                  _nameController.text.trim(),
                                );
                                if (success && mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── Sign In Link ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.textTertiaryDark,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Sign In',
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
