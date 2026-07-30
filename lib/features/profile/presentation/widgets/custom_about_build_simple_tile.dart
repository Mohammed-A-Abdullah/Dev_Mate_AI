import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAboutBuildSimpleTile extends StatelessWidget {
  const CustomAboutBuildSimpleTile({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,
          ),
        ],
      ),
    );
  }
}