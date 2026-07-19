import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/gradient_button.dart';
import '../../animations/fade_animation.dart';

/// Forgot password screen with reset email functionality.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // ─── Back Button ───
                GestureDetector(
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
                const SizedBox(height: 32),

                if (!_emailSent) ...[
                  // ─── Title ───
                  FadeAnimation(
                    child: Text(
                      'Reset Password',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      "Enter your email and we'll send you a link to reset your password.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ─── Email Field ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 200),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: AppColors.textPrimaryDark),
                        decoration: const InputDecoration(
                          hintText: 'Email address',
                          prefixIcon:
                              Icon(Icons.email_outlined, size: 20),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!v.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ─── Send Button ───
                  FadeAnimation(
                    delay: const Duration(milliseconds: 300),
                    child: GradientButton(
                      text: 'Send Reset Link',
                      isLoading: authProvider.isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await authProvider.sendPasswordReset(
                            _emailController.text.trim(),
                          );
                          if (success && mounted) {
                            setState(() => _emailSent = true);
                          }
                        }
                      },
                    ),
                  ),
                ] else ...[
                  // ─── Success State ───
                  const Spacer(),
                  FadeAnimation(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.success.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mark_email_read_rounded,
                              color: AppColors.success,
                              size: 48,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Email Sent! ✉️',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'We sent a password reset link to\n${_emailController.text.trim()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.textTertiaryDark),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          GradientButton(
                            text: 'Back to Login',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ],
            ),
          ),
            ),
          ),
        ),
      ),
    );
  }
}
