import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
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
      onTap: () {
        GoRouter.of(context).pushNamed(tool.screen);
      },
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: Theme.of(context).extension<HomeThemeExtension>()!.homeCard,
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
                  color: Theme.of(
                    context,
                  ).extension<HomeThemeExtension>()!.iconCardQuickTool,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(tool.icon, color: tool.iconColor),
              ),
              HeightSpace(height: 5),
              Text(
                tool.title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              HeightSpace(height: 5),
              Text(
                tool.description,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
