import 'dart:io';

import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();

  Future<String> updatePhoto(File imageFile);
  Future<void> deletePhoto();

  Future<void> logout();
  Future<void> deleteAccount();

  Future<void> changePassword(String newPassword);
     Future<void> updateProfileDetails(String name);

}
