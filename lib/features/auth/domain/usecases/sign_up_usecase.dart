import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthUserEntity?> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return repository.signUp(name: name, email: email, password: password);
  }
}
