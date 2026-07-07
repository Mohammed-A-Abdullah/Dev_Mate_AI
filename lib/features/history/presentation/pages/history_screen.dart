import 'dart:ffi';

import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_text_field.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> filterChip = [
      'All',
      'Chat',
      'README',
      'Code Review',
      'Project Planner',
      'Debug',
    ];
    return Scaffold(
      backgroundColor: Color(0xff111319),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff111319),
        title: Text(
          'DevMate AI',
          style: GoogleFonts.geist(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffB5C4FF),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(height: 24),
              Text(
                'Activity History',
                style: GoogleFonts.geist(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffE2E2EB).withValues(alpha: 0.9),
                ),
              ),
              HeightSpace(height: 16),
              CustomTextField(
                borderColor: Color(0xff434654),
                fillColor: Color(0xff1E1F26),
                hintText: 'Search history...',
                hintTextStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Color(0xff434654),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffC3C5D7),
                  size: 20.sp,
                ),
                radius: 50.r,
              ),
              HeightSpace(height: 32),
              SizedBox(
                height: 33.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterChip.length,
                  physics: BouncingScrollPhysics(),

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Container(
                        height: 34.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 6.h,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff1E1F26),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Text(
                          filterChip[index],
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11.sp,
                            color: Color(0xffB5C4FF),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
                      HeightSpace(height: 12),
                      Chip(
                        label: Text(
                          'flutter',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12.sp,
                            color: const Color(0xff8d90a0),
                          ),
                        ),
                        backgroundColor: const Color(0xff0C0E14),
                        side: BorderSide(color: Colors.transparent),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
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
