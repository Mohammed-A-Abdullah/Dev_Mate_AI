import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
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
    final homeTheme = Theme.of(context).extension<HomeThemeExtension>()!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: homeTheme.homeCard,

        borderRadius: BorderRadius.circular(28.r),

        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1.w,
        ),

        gradient: RadialGradient(
          center: Alignment(0.7, 0.9),
          radius: 1.2,
          colors: [
            homeTheme.homeCardGradient,
            homeTheme.secondHomeCardGradient,
          ],
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
              color: Theme.of(context).colorScheme.secondary,
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
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 16.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  WidthSpace(width: 4),
                  Text(
                    'New Chat',
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onPrimary,
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
