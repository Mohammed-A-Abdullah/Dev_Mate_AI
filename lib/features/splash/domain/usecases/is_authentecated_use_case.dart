import 'package:dev_mate_ai/features/splash/domain/repositories/splash_repository.dart';

class IsAuthentecatedUseCase {
  final SplashRepository repository;

  IsAuthentecatedUseCase({required this.repository});

  Future<bool> call(){
    return repository.isAuthenticated();
  }
}