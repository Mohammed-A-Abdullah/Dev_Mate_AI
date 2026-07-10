import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          title,
          style: GoogleFonts.geist(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}