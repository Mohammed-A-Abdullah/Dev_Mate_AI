import '../repositories/splash_repository.dart';

class CheckOnboarding {
  final SplashRepository repository;

  CheckOnboarding(this.repository);

  Future<bool> call() {
    return repository.isOnboardingCompleted();
  }
}
