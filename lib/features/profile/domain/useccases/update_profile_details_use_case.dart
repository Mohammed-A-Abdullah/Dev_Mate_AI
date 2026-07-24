import '../repositories/profile_repository.dart';

class UpdateProfileDetailsUseCase {
  final ProfileRepository repository;

  UpdateProfileDetailsUseCase(this.repository);

  Future<void> call(String name) {
    return repository.updateProfileDetails(name);
  }
}
