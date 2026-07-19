import 'package:flutter/material.dart';

class AuthThemeExtension extends ThemeExtension<AuthThemeExtension> {

  final Color socialBackground;

  AuthThemeExtension({required this.socialBackground});
  @override
  ThemeExtension<AuthThemeExtension> copyWith({Color? socialBackground}) {
    return AuthThemeExtension(socialBackground: socialBackground??this.socialBackground);
  }

  @override
  ThemeExtension<AuthThemeExtension> lerp(covariant AuthThemeExtension ? other, double t) {
    if(other is! AuthThemeExtension ){
      return this;
    }
    return AuthThemeExtension(socialBackground: Color.lerp(socialBackground, other.socialBackground, t)!);
  }
}