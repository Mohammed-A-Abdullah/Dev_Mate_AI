import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create your account',
          style: GoogleFonts.geist(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffE2E2EB),
          ),
        ),
        HeightSpace(height: 8),
        Text(
          'Set up a DevMate AI profile to keep your experience secure.',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xffC3C5D7),
            height: 1.5,
          ),
        ),
        HeightSpace(height: 32),
        CustomTextField(
          controller: nameController,
          hintText: 'Full name',
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Color(0xffC3C5D7),
          ),
          fillColor: const Color(0xff1E1F26),
          borderColor: const Color(0xff434654),
          radius: 18.r,
          textStyle: GoogleFonts.inter(color: Colors.white),
          hintTextStyle: GoogleFonts.inter(
            color: const Color(0xff6F7385),
            fontSize: 14.sp,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
        HeightSpace(height: 16),
        CustomTextField(
          controller: emailController,
          keyBoardType: TextInputType.emailAddress,
          hintText: 'Email address',
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Color(0xffC3C5D7),
          ),
          fillColor: const Color(0xff1E1F26),
          borderColor: const Color(0xff434654),
          radius: 18.r,
          textStyle: GoogleFonts.inter(color: Colors.white),
          hintTextStyle: GoogleFonts.inter(
            color: const Color(0xff6F7385),
            fontSize: 14.sp,
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
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xffC3C5D7)),
          fillColor: const Color(0xff1E1F26),
          borderColor: const Color(0xff434654),
          radius: 18.r,
          textStyle: GoogleFonts.inter(color: Colors.white),
          hintTextStyle: GoogleFonts.inter(
            color: const Color(0xff6F7385),
            fontSize: 14.sp,
          ),
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
          hintText: 'Confirm password',
          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xffC3C5D7)),
          fillColor: const Color(0xff1E1F26),
          borderColor: const Color(0xff434654),
          radius: 18.r,
          textStyle: GoogleFonts.inter(color: Colors.white),
          hintTextStyle: GoogleFonts.inter(
            color: const Color(0xff6F7385),
            fontSize: 14.sp,
          ),
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
              backgroundColor: const Color(0xffB5C4FF),
              foregroundColor: const Color(0xff00297B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            child: Text(
              'Create account',
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
