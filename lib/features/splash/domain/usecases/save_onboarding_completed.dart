import '../repositories/splash_repository.dart';

class SaveOnboardingCompleted {
  final SplashRepository repository;

  SaveOnboardingCompleted(this.repository);

  Future<bool> call() {
    return repository.saveOnboardingCompleted();
  }
}
