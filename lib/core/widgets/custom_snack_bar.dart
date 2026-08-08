import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
    int? time,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    final bool isTablet = width >= 600;
    final bool isDesktop = width >= 1024;

    final double horizontalMargin = isDesktop
        ? 32
        : isTablet
        ? 24
        : 16;

    final double fontSize = isDesktop
        ? 15
        : isTablet
        ? 14.5
        : 14;

    final double maxWidth = isDesktop
        ? 600
        : isTablet
        ? 550
        : double.infinity;

    final snackBar = SnackBar(
      duration: Duration(seconds: time ?? 3),

      behavior: SnackBarBehavior.floating,

      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 16),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      elevation: 3,

      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.error,

      closeIconColor: Theme.of(context).colorScheme.secondary,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      content: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Text(
            message,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: textColor ?? AppColors.secondary,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
