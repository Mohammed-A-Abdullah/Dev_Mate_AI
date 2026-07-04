import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingEntity pageData;

  const OnboardingPageContent({super.key, required this.pageData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeightSpace(height: 40),
          Icon(pageData.icon, size: 100.sp, color: const Color(0xffB5C4FF)),
          HeightSpace(height: 60),
          Text(
            pageData.title,
            style: GoogleFonts.geist(
              fontSize: 24.sp,
              color: const Color(0xffE2E2EB),
              fontWeight: FontWeight.w500,
            ),
          ),
          HeightSpace(height: 12),
          SizedBox(
            width: 310.w,
            child: Text(
              pageData.description,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xffC3C5D7),
                letterSpacing: 0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
