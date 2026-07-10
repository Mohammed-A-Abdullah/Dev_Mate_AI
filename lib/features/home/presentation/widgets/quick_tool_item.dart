import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class QuickToolItem extends StatelessWidget {
  final HomeQuickToolEntity tool;
  

  const QuickToolItem({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        GoRouter.of(context).pushNamed(tool.screen);
      },
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: const Color(0xff1A1D26),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xff0C0E14),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  tool.icon,
                  color: tool.iconColor,
                ),
              ),
              HeightSpace(height: 5),
              Text(
                tool.title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE2E2EB),
                ),
              ),
              HeightSpace(height: 5),
              Text(
                tool.description,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffE2E2EB),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
