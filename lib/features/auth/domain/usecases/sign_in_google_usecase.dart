import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SignInGoogleUseCase {
  final AuthRepository repository;

  SignInGoogleUseCase(this.repository);

  Future<AuthUserEntity?> call() {
    return repository.signInWithGoogle();
  }
}
