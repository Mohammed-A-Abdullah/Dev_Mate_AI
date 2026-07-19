import 'package:flutter/material.dart';

class SplashThemeExtension extends ThemeExtension<SplashThemeExtension> {
  final Color splashText;

  SplashThemeExtension({required this.splashText});
  @override
  ThemeExtension<SplashThemeExtension> copyWith({Color? splashText}) {
    return SplashThemeExtension(
      splashText: splashText ?? this.splashText,
    );
  }

  @override
  ThemeExtension<SplashThemeExtension> lerp(
    covariant SplashThemeExtension? other,
    double t,
  ) {
    if (other is! SplashThemeExtension) {
      return this;
    }
    return SplashThemeExtension(
      splashText: Color.lerp(
        splashText,
        other.splashText,
        t,
      )!,
    );
  }
}
