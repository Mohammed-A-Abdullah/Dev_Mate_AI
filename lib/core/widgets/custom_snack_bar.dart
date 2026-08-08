import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum SnackBarType { success, error, warning, info }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.error,
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

    final colors = _colors(context, type);
    final resolvedBackground = backgroundColor ?? colors.background;
    final resolvedText = textColor ?? colors.foreground;

    final snackBar = SnackBar(
      duration: Duration(seconds: time ?? 3),

      behavior: SnackBarBehavior.floating,

      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 16),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      elevation: 3,

      backgroundColor: resolvedBackground,

      closeIconColor: resolvedText,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      content: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Row(
            children: [
              Icon(colors.icon, color: resolvedText, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: resolvedText,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void success(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.success);
  }

  static void error(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.error);
  }

  static void warning(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.warning);
  }

  static void info(BuildContext context, {required String message}) {
    show(context, message: message, type: SnackBarType.info);
  }

  static ({Color background, Color foreground, IconData icon}) _colors(
    BuildContext context,
    SnackBarType type,
  ) {
    final theme = Theme.of(context);
    switch (type) {
      case SnackBarType.success:
        return (
          background: const Color(0xff15803D),
          foreground: Colors.white,
          icon: Icons.check_circle_outline,
        );
      case SnackBarType.warning:
        return (
          background: const Color(0xffB45309),
          foreground: Colors.white,
          icon: Icons.warning_amber_rounded,
        );
      case SnackBarType.info:
        return (
          background: theme.colorScheme.primary,
          foreground: theme.colorScheme.onPrimary,
          icon: Icons.info_outline,
        );
      case SnackBarType.error:
        return (
          background: theme.colorScheme.error,
          foreground: theme.colorScheme.onError,
          icon: Icons.error_outline,
        );
    }
  }
}
