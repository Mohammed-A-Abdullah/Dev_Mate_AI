import 'package:flutter/material.dart';

class HomeThemeExtension extends ThemeExtension<HomeThemeExtension> {
  final Color homeCard;
  final Color homeCardGradient;
  final Color secondHomeCardGradient;
  final Color iconCardQuickTool;

  const HomeThemeExtension({
    required this.homeCard,
    required this.homeCardGradient,
    required this.secondHomeCardGradient, required this.iconCardQuickTool,
  });

  @override
  HomeThemeExtension copyWith({
    Color? homeCard,
    Color? homeCardGradient,
    Color? secondHomeCardGradient,
    Color? iconCardQuickTool
  }) {
    return HomeThemeExtension(
      homeCard: homeCard ?? this.homeCard,
      homeCardGradient: homeCardGradient ?? this.homeCardGradient,
      secondHomeCardGradient:
          secondHomeCardGradient ?? this.secondHomeCardGradient,
      iconCardQuickTool: iconCardQuickTool ?? this.iconCardQuickTool,
    );
  }

  @override
  HomeThemeExtension lerp(covariant HomeThemeExtension? other, double t) {
    if (other == null) return this;

    return HomeThemeExtension(
      homeCard: Color.lerp(homeCard, other.homeCard, t)!,
      homeCardGradient: Color.lerp(
        homeCardGradient,
        other.homeCardGradient,
        t,
      )!,
      secondHomeCardGradient: Color.lerp(
        secondHomeCardGradient,
        other.secondHomeCardGradient,
        t,
      )!, iconCardQuickTool: Color.lerp(iconCardQuickTool, other.iconCardQuickTool, t)!,
    );
  }
}
