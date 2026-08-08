import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
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
    required this.isLoading,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final GlobalKey<FormState> formKey;

  final VoidCallback onSubmit;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: nameController,
          hintText: local.fullName,
          prefixIcon: const Icon(Icons.person_outline),
          keyBoardType: TextInputType.name,
        ),

        const SizedBox(height: 16),

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

        const SizedBox(height: 16),

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

        const SizedBox(height: 16),

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

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,

            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,

              foregroundColor: theme.colorScheme.onPrimary,

              disabledBackgroundColor: theme.colorScheme.primary.withValues(
                alpha: .6,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),

            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),

              child: isLoading
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      key: const ValueKey('text'),

                      local.createAccount,

                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .5,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
