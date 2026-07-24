import 'package:dev_mate_ai/features/auth/domain/repository/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;


  UpdatePasswordUseCase({required this.repository});

  Future<void> call(String password){
    return repository.updatePassword(password);
  }
}