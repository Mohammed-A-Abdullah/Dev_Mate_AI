import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 1024;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= desktopBreakpoint) {
          return desktop;
        }

        if (width >= mobileBreakpoint) {
          return tablet ?? mobile;
        }

        return mobile;
      },
    );
  }
}
