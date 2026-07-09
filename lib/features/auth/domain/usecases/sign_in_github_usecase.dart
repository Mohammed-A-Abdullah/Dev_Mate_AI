import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SignInGithubUseCase {
  final AuthRepository repository;

  SignInGithubUseCase(this.repository);

  Future<AuthUserEntity?> call() {
    return repository.signInWithGithub();
  }
}
