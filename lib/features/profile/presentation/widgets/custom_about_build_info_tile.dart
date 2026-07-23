import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAboutBuildInfoTile extends StatelessWidget {
  const CustomAboutBuildInfoTile({super.key, required this.title, required this.subtitle, this.subtitleColor, this.trailingIcon,this.isLongText=false});
  final String title;
    final String subtitle;
    final bool isLongText;
    final Color? subtitleColor;
    final IconData? trailingIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: isLongText
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: subtitleColor ?? const Color(0xff8E92A8),
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (trailingIcon != null) ...[
            SizedBox(width: 8.w),
            Icon(trailingIcon, color: const Color(0xff8E92A8), size: 16.sp),
          ] else ...[
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xff8E92A8),
              size: 14.sp,
            ),
          ],
        ],
      ),
    );
  }
}