import 'package:flutter/material.dart';

class ProfileThemeExtension extends ThemeExtension<ProfileThemeExtension> {
  final Color profilCard;
  final Color profilCardGradient;
  final Color secondprofilCardGradient;
 

  const ProfileThemeExtension({
    required this.profilCard,
    required this.profilCardGradient,
    required this.secondprofilCardGradient,
  });

  @override
  ProfileThemeExtension copyWith({
    Color? profilCard,
    Color? profilCardGradient,
    Color? secondprofilCardGradient,
    Color? iconCardQuickTool,
  }) {
    return ProfileThemeExtension(
      profilCard: profilCard ?? this.profilCard,
      profilCardGradient: profilCardGradient ?? this.profilCardGradient,
      secondprofilCardGradient:
          secondprofilCardGradient ?? this.secondprofilCardGradient,
    );
  }

  @override
  ProfileThemeExtension lerp(covariant ProfileThemeExtension? other, double t) {
    if (other == null) return this;

    return ProfileThemeExtension(
      profilCard: Color.lerp(profilCard, other.profilCard, t)!,
      profilCardGradient: Color.lerp(
        profilCardGradient,
        other.profilCardGradient,
        t,
      )!,
      secondprofilCardGradient: Color.lerp(
        secondprofilCardGradient,
        other.secondprofilCardGradient,
        t,
      )!,
    );
  }
}
