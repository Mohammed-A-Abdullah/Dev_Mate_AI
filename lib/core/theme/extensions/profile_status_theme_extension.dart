import 'package:flutter/material.dart';

@immutable
class ProfileStatsThemeExtension
    extends ThemeExtension<ProfileStatsThemeExtension> {
  final Color chatsColor;
  final Color readmeColor;
  final Color analysisColor;
  final Color debugColor;
  final Color explainColor;
  final Color reviewColor;

  const ProfileStatsThemeExtension({
    required this.chatsColor,
    required this.readmeColor,
    required this.analysisColor,
    required this.debugColor,
    required this.explainColor,
    required this.reviewColor,
  });

  @override
  ProfileStatsThemeExtension copyWith({
    Color? chatsColor,
    Color? readmeColor,
    Color? analysisColor,
    Color? debugColor,
    Color? explainColor,
    Color? reviewColor,
  }) {
    return ProfileStatsThemeExtension(
      chatsColor: chatsColor ?? this.chatsColor,
      readmeColor: readmeColor ?? this.readmeColor,
      analysisColor: analysisColor ?? this.analysisColor,
      debugColor: debugColor ?? this.debugColor,
      explainColor: explainColor ?? this.explainColor,
      reviewColor: reviewColor ?? this.reviewColor,
    );
  }

  @override
  ProfileStatsThemeExtension lerp(
    ThemeExtension<ProfileStatsThemeExtension>? other,
    double t,
  ) {
    if (other is! ProfileStatsThemeExtension) return this;

    return ProfileStatsThemeExtension(
      chatsColor: Color.lerp(chatsColor, other.chatsColor, t)!,
      readmeColor: Color.lerp(readmeColor, other.readmeColor, t)!,
      analysisColor: Color.lerp(analysisColor, other.analysisColor, t)!,
      debugColor: Color.lerp(debugColor, other.debugColor, t)!,
      explainColor: Color.lerp(explainColor, other.explainColor, t)!,
      reviewColor: Color.lerp(reviewColor, other.reviewColor, t)!,
    );
  }
}
