import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _initializedKey = 'app_initialized';
  static const String themeKey = 'is_dark_mode';
  static const String languageKey = 'selected_language';
  static const String onboardingKey = 'onboarding_screen';
  static const String authEmailKey = 'auth_email';
  static const String authPasswordKey = 'auth_password';
  static const String authStatusKey = 'auth_status';

  static Future<void> initializeDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_initializedKey) ?? false) {
      return;
    }

    await prefs.setBool(themeKey, true);
    await prefs.setString(languageKey, 'en');
    await prefs.remove(onboardingKey);
    await prefs.setBool(_initializedKey, true);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  static Future<bool> completedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(onboardingKey, true);
  }

  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(authStatusKey) ?? false;
  }

  static Future<bool> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = await prefs.setString(authEmailKey, email);
    final savedPassword = await prefs.setString(authPasswordKey, password);
    final savedStatus = await prefs.setBool(authStatusKey, true);
    return savedEmail && savedPassword && savedStatus;
  }

  static Future<String?> getStoredEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(authEmailKey);
  }

  static Future<String?> getStoredPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(authPasswordKey);
  }

  static Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authEmailKey);
    await prefs.remove(authPasswordKey);
    await prefs.setBool(authStatusKey, false);
  }
}
