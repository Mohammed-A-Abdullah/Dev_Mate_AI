import '../repository/auth_repository.dart';

class CheckAuthStatusUseCase {
  CheckAuthStatusUseCase(this.repository);

  final AuthRepository repository;

  Future<bool> call() async {
    return repository.isAuthenticated();
  }
}
