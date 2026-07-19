import 'package:flutter/material.dart';

class HistoryThemeExtension extends ThemeExtension<HistoryThemeExtension> {
  final Color historyCard;
  final Color chipLableText;
  final Color timeago;

  HistoryThemeExtension({
    required this.historyCard,
    required this.chipLableText,
    required this.timeago,
  });
  @override
  ThemeExtension<HistoryThemeExtension> copyWith({
    Color? historyCard,
    Color? chipLableText,
    Color? timeago,
  }) {
    return HistoryThemeExtension(
      historyCard: historyCard ?? this.historyCard,
      chipLableText: chipLableText ?? this.chipLableText,
      timeago: timeago ?? this.timeago,
    );
  }

  @override
  ThemeExtension<HistoryThemeExtension> lerp(
    covariant HistoryThemeExtension? other,
    double t,
  ) {
    if (other == null) return this;
    return HistoryThemeExtension(
      historyCard: Color.lerp(historyCard, other.historyCard, t)!,
      chipLableText: Color.lerp(chipLableText, other.chipLableText, t)!,
      timeago: Color.lerp(timeago, other.timeago, t)!,
    );
  }
}
