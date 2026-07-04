import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SignInUseCase {
  SignInUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthUserEntity?> call({
    required String email,
    required String password,
  }) async {
    return repository.signIn(email: email, password: password);
  }
}
