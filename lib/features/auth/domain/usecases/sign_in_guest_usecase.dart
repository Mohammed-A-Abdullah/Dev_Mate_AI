import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SignInGuestUseCase {
  final AuthRepository repository;

  SignInGuestUseCase(this.repository);

  Future<AuthUserEntity?> call() {
    return repository.signInAnonymously();
  }
}
