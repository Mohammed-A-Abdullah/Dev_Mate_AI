import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/theme/extensions/auth_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/chat_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/dropdown_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/history_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/splash_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgound,

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xffB5C4FF),
    ),
    iconTheme: IconThemeData(color: Color(0xffC3C5D7)),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgound,
      iconTheme: IconThemeData(color: AppColors.primary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
      filled: true,
      fillColor: const Color(0xff1E1F26),

      hintStyle: GoogleFonts.inter(
        color: const Color(0xff6F7385),
        fontSize: 14.sp,
      ),

      contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: Color(0xff434654)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: Colors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    ),

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.onsurface,
      onSurface: AppColors.onsurface,
      outline: AppColors.outline,
    ),
    extensions: [
      ChatThemeExtension(
        chatBotMessage: const Color(0xff1D1E25),
        codeBackgound: Colors.black.withValues(alpha: 0.3),
      ),
      HomeThemeExtension(
        homeCard: Color(0xff171923),
        homeCardGradient: Color(0xff221C38),
        secondHomeCardGradient: Color(0xff171923),
        iconCardQuickTool: Color(0xff0C0E14),
      ),
      HistoryThemeExtension(
        historyCard: Color(0xff1A1D26),
        chipLableText: Color(0xff8d90a0),
        timeago: Color(0xff8d90a0),
      ),
      AuthThemeExtension(socialBackground: Color(0xff1A1E27)),
      SplashThemeExtension(splashText: Color(0xff8D90A0)),
      DropdownThemeExtension(dropdownColor: Color(0xff1E1F26),textDropdown: AppColors.secondary)
    ],
  );
}
