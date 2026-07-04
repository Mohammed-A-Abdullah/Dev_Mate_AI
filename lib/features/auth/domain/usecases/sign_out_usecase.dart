import '../repository/auth_repository.dart';

class SignOutUseCase {
  SignOutUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call() async {
    await repository.signOut();
  }
}
