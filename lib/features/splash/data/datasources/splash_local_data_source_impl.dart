import '../../../../core/services/app_preferences.dart';
import 'splash_local_data_source.dart';
class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  @override
  Future<bool> isOnboardingCompleted() {
    return AppPreferences.isOnboardingCompleted();
  }

  @override
  Future<bool> saveOnboardingCompleted() {
    return AppPreferences.completedOnboarding();
  }
  
  @override
  Future<bool> isAuthenticated() {
    return AppPreferences.isAuthenticated();
  }
}
