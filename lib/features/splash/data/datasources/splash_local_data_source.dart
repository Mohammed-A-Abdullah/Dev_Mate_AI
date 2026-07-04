import '../../../../core/services/app_preferences.dart';
import 'splash_local_data_source_impl.dart';

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  @override
  Future<bool> isOnboardingCompleted() {
    return AppPreferences.isOnboardingCompleted();
  }
}
