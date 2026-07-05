import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_data_source_impl.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource local;

  SplashRepositoryImpl(this.local);

  @override
  Future<bool> isOnboardingCompleted() {
    return local.isOnboardingCompleted();
  }
  
  @override
  Future<bool> saveOnboardingCompleted() {
    return local.saveOnboardingCompleted();
  }
}
