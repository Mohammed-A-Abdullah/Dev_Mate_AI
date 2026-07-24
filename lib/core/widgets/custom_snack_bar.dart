import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      snackBarAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 800),
        reverseCurve: Curves.easeInOut,
      ),
      SnackBar(
        duration: const Duration(seconds: 3),
        padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        elevation: 3,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        backgroundColor: backgroundColor ?? Colors.red,
        content: Text(
          message,style: GoogleFonts.inter(color: AppColors.secondary,fontSize: 14.sp,fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
