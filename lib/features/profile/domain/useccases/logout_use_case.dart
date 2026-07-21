import 'package:dev_mate_ai/features/profile/domain/repositories/profile_repository.dart';

class LogoutUseCase {

  final ProfileRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> call() {
    return repository.logout();
  }
}