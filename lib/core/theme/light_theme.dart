import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/theme/extensions/auth_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/chat_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/dropdown_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/history_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/splash_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'extensions/profile_status_theme_extension.dart';

class LightTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    dividerColor: Color(0xffE8ECF5),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.lightPrimary,
    ),
    iconTheme: const IconThemeData(color: AppColors.lightSecondary),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: AppColors.lightPrimary),
      titleTextStyle: TextStyle(color: AppColors.lightOnSecondary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
      filled: true,
      fillColor: const Color(0xffFFFFFF),
      
      hintStyle: GoogleFonts.inter(
        color: const Color(0xff6F7385),
        fontSize: 14.sp,
      ),

      contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: AppColors.lightOutline),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: AppColors.lightError),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: AppColors.lightError, width: 2),
      ),
    ),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.lightSurface),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSecondary,
      outline: AppColors.lightOutline,
    ),
    extensions: [
      ChatThemeExtension(
        chatBotMessage: const Color(0xffF0F3FA),
        codeBackgound: const Color(0xffE2E4EB),
      ),
      HomeThemeExtension(
        homeCard: const Color(0xffFFFFFF),
        homeCardGradient: const Color(0xffE6EDFF),
        secondHomeCardGradient: const Color(0xffFFFFFF),
        iconCardQuickTool: const Color(0xffF5F6FA),
      ),
      HistoryThemeExtension(
        historyCard: const Color(0xffFFFFFF),
        chipLableText: const Color(0xff4A4D5E),
        timeago: const Color(0xff6F7385),
      ),
      AuthThemeExtension(socialBackground: const Color(0xffFFFFFF)),
      SplashThemeExtension(splashText: const Color(0xff4A4D5E)),
      DropdownThemeExtension(
        dropdownColor: const Color(0xffFFFFFF),
        textDropdown: AppColors.lightSecondary,
      ),
      ProfileThemeExtension(
        profilCardGradient: const Color(0xffE6EDFF),
        secondprofilCardGradient: const Color(0xffC4D3FF),
        profilCard: const Color(0xffFFFFFF),
      ),
      const ProfileStatsThemeExtension(
    chatsColor: Color(0xffB5C4FF),
    readmeColor: Color(0xffC79DFF),
    analysisColor: Color(0xff6EE7B7),
    debugColor: Color(0xffFFB86C),
    explainColor: Color(0xff7DD3FC),
    reviewColor: AppColors.lightSecondary,
    ),
    ],
  );
}
