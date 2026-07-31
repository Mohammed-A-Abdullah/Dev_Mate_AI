import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _langKey = 'selected_language';

  LocaleCubit() : super(const Locale('en')) {
    _loadLocale();
  }

  Future<void> changeLanguage(String languageCode) async {
    emit(Locale(languageCode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, languageCode);
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(_langKey);
    if (savedLang != null) {
      emit(Locale(savedLang));
    }
  }
}
