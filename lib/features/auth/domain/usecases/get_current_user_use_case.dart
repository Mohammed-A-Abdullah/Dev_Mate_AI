import 'package:dev_mate_ai/features/auth/domain/repository/auth_repository.dart';
import '../entities/auth_user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});
  Future<AuthUserEntity?> call() {
    return repository.getCurrentUser();
  }
}