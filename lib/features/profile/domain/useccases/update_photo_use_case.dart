import 'dart:io';

import '../repositories/profile_repository.dart';

class UpdatePhotoUseCase {
  final ProfileRepository repository;

  UpdatePhotoUseCase(this.repository);

  Future<String> call(File imageFile) {
    return repository.updatePhoto(imageFile);
  }
}
