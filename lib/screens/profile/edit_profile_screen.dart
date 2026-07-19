import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/glass_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    final profileProvider = context.read<ProfileProvider>();
    final user = profileProvider.user;
    
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _ageController = TextEditingController(text: user?.age?.toString() ?? '');
    _weightController = TextEditingController(text: user?.weight?.toString() ?? '');
    _heightController = TextEditingController(text: user?.height?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      final data = {
        'displayName': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()),
        'weight': double.tryParse(_weightController.text.trim()),
        'height': double.tryParse(_heightController.text.trim()),
      };
      // Remove null values so we don't accidentally overwrite with nulls if empty
      data.removeWhere((key, value) => value == null && key != 'displayName');
      
      await context.read<ProfileProvider>().updateProfile(data);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark.withValues(alpha: 0.9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                      color: AppColors.cardDark,
                    ),
                    child: const Icon(Icons.person, size: 50, color: AppColors.textSecondaryDark),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxxl),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField('Full Name', _nameController, TextInputType.name),
                    const SizedBox(height: AppSpacing.lg),
                    _buildInputField('Age', _ageController, TextInputType.number),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(child: _buildInputField('Weight (kg)', _weightController, const TextInputType.numberWithOptions(decimal: true))),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(child: _buildInputField('Height (cm)', _heightController, const TextInputType.numberWithOptions(decimal: true))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              GradientButton(
                text: 'Save Changes',
                isLoading: _isLoading,
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondaryDark)),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: AppColors.textPrimaryDark),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.backgroundDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
