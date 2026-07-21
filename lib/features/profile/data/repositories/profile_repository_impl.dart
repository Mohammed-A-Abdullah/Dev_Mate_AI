import 'package:dev_mate_ai/features/profile/domain/entities/profile_entity.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<ProfileEntity> getProfile() {
    return remote.getProfile();
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

  @override
  Future<void> updatePhoto() {
    return remote.updatePhoto();
  }
}
