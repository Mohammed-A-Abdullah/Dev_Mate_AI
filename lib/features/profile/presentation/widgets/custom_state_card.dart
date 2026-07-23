import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStateCard extends StatelessWidget {
  const CustomStateCard({super.key, required this.value, required this.label, required this.valueColor});
final String value;
  final String label;
  final Color valueColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xff1C1E28),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.geist(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xffC3C5D7),
            ),
          ),
        ],
      ),
    );
  }
}