import 'package:dev_mate_ai/generated/l10n.dart';

class  HomeHelper {
  static String getGreeting(S local) {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return local.goodMorning;
    } else if (hour >= 12 && hour < 17) {
      return local.goodAfternoon;
    } else {
      return local.goodEvening;
    }
  }

  static String getFormattedName(
    String? displayName,
    String fallbackUser, {
    int maxLength = 12,
  }) {
    if (displayName == null || displayName.trim().isEmpty) {
      return fallbackUser;
    }
    final firstName = displayName.trim().split(RegExp(r'\s+')).first;
    if (firstName.length > maxLength) {
      return '${firstName.substring(0, maxLength)}...';
    }

    return firstName;
  }

}
