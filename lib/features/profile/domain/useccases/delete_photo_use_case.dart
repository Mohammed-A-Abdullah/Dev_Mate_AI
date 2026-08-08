import '../repositories/profile_repository.dart';

class DeletePhotoUseCase {
  final ProfileRepository repository;

  DeletePhotoUseCase(this.repository);

  Future<void> call() {
    return repository.deletePhoto();
  }
}
