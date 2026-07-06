import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111319),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeightSpace(height: 32),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff1A1D26),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Title',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffE2E2EB),
                            ),
                          ),
                        ],
                      ),
                      HeightSpace(height: 8),
                      Text(
                        'description data lab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lablab lab lab',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Color(0xffC3C5D7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      HeightSpace(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 24.h,
                        constraints: BoxConstraints(
                          minWidth: 45.w,
                          maxWidth: 74.w,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff0C0E14),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Chat',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12.sp,
                            color: Color(0xff8d90a0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
