import 'dart:io';

import 'package:dev_mate_ai/core/services/app_preferences.dart';
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
  Future<void> logout() async {
    await remote.logout();
    await AppPreferences.clearAuth();
  }

  @override
  Future<String> updatePhoto(File imageFile) {
    return remote.updatePhoto(imageFile);
  }
  
  @override
  Future<void> changePassword(String newPassword) {
    return remote.changePassword(newPassword);
  }
  
  @override
  Future<void> deleteAccount() async {
    await remote.deleteAccount();
    await AppPreferences.clearAuth();
  }
  
  @override
  Future<void> updateProfileDetails(String name) {
    return remote.updateProfileDetails(name);
  }

}
