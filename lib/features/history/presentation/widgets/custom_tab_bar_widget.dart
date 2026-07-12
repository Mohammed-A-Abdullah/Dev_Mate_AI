import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });
  final String text;
  final void Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 34.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xffB5C4FF) : Color(0xff1E1F26),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Text(
            text,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11.sp,
              color: isSelected ? Color(0xff1E1F26) : Color(0xffB5C4FF),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
