import 'package:dev_mate_ai/features/profile/domain/repositories/profile_repository.dart';

import '../entities/profile_entity.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});
  
  Future<ProfileEntity> call(){
    return repository.getProfile();
  }
}