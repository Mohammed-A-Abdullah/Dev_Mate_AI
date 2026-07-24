import 'dart:io';

import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<void> logout();

  Future<String> updatePhoto(File imageFile);

  Future<void> deleteAccount();

   Future<void> changePassword(String newPassword);
   Future<void> updateProfileDetails(String name);
}
