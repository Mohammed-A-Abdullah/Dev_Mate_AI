import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNewChatContainer extends StatelessWidget {
  const CustomNewChatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.homeCard,

        borderRadius: BorderRadius.circular(28.r),

        border: Border.all(color: AppColors.homeCardBorder, width: 1.w),

        gradient: const RadialGradient(
          center: Alignment(0.7, 0.9),
          radius: 1.2,
          colors: [AppColors.homeCardGredian, AppColors.secondHomeCardGredian],
          stops: [0.0, 0.7],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'What can I help you build today?',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText,
            ),
          ),
          HeightSpace(height: 16),
          GestureDetector(
            onTap: () {
              context.read<NavigationCubit>().changeIndex(1);
            },
            child: Container(
              height: 36.h,
              width: 115.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 16.sp,
                    color: AppColors.textButtonColor,
                  ),
                  WidthSpace(width: 4),
                  Text(
                    'New Chat',
                    style: GoogleFonts.inter(
                      color: AppColors.textButtonColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
