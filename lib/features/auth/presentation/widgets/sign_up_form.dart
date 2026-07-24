import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onSubmit,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: nameController,
          hintText: local.fullName,
          prefixIcon: const Icon(Icons.person_outline),
          keyBoardType: TextInputType.text,
        ),
        HeightSpace(height: 16),
        CustomTextField(
          controller: emailController,
          keyBoardType: TextInputType.emailAddress,
          hintText: local.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            return null;
          },
        ),
        HeightSpace(height: 16),
        CustomTextField(
          controller: passwordController,
          isPassword: true,
          hintText: local.password,
          prefixIcon: const Icon(Icons.lock_outline),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Password is required';
            }
            if (value.trim().length < 6) {
              return 'Use at least 6 characters';
            }
            return null;
          },
        ),
        HeightSpace(height: 16),
        CustomTextField(
          controller: confirmPasswordController,
          isPassword: true,
          hintText: local.comfirmPass,
          prefixIcon: const Icon(Icons.lock_outline),

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please confirm your password';
            }
            if (value.trim() != passwordController.text.trim()) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        HeightSpace(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            child: Text(
              local.createAccount,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.55.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
