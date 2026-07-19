import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Spacer(),
              CircleAvatar(
                radius: 45.r,
                child: Icon(Icons.mark_email_read_outlined, size: 45.sp),
              ),

              HeightSpace(height: 30),

              Text(
                "Check your email",
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary
                ),
              ),

              HeightSpace(height: 16),

              Text(
                "We've sent a password reset link to:",
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),

              HeightSpace(height: 8),

              Text(
                email,
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              HeightSpace(height: 20),

              Text(
                "Open your inbox and click the reset link to create a new password.",
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13.sp,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  onPressed: () {
                    context.goNamed(RouteName.authScreen);
                  },
                  child: Text(
                    "Back to Sign In",
                    style: GoogleFonts.jetBrainsMono(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),

              HeightSpace(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Didn't receive the email?",
                  style: GoogleFonts.jetBrainsMono(fontSize: 12.sp),
                ),
              ),
              Spacer(),
              HeightSpace(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
