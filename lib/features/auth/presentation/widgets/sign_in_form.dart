import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: emailController,
          keyBoardType: TextInputType.emailAddress,
          hintText: local.emailAddress,
          prefixIcon: const Icon(
            Icons.email_outlined,
          ),
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
          prefixIcon: const Icon(Icons.lock_outline,),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return local.passValidate;
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
              local.signin,
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
