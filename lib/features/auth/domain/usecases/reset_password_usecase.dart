import 'package:dev_mate_ai/features/auth/domain/repository/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository repository;

  ResetPasswordUsecase({required this.repository});

  Future<void>call(String email){
    return repository.resetPassword(email);
  }

}