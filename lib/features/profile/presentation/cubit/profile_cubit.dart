import 'dart:io';

import 'package:dev_mate_ai/features/profile/domain/useccases/change_password_use_case.dart';
import 'package:dev_mate_ai/features/profile/domain/useccases/delete_account_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useccases/logout_use_case.dart';
import '../../domain/useccases/get_profile_use_case.dart';
import '../../domain/useccases/update_photo_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;
    final UpdatePhotoUseCase updatePhotoUseCase;
    final DeleteAccountUseCase deleteAccountUseCase;
    final ChangePasswordUseCase changePasswordUseCase;
  ProfileCubit(this.getProfileUseCase, this.logoutUseCase, {required this.updatePhotoUseCase, required this.deleteAccountUseCase, required this.changePasswordUseCase})
    : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    try {
      final profile = await getProfileUseCase();

      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
      print(e);
    }
  }

  Future<void> updatePhoto(File file) async {
    try {
      await updatePhotoUseCase(file);

      await loadProfile();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> changePassword(String newPassword) async {
    emit(ChangePasswordLoading());
    try {
      await changePasswordUseCase(newPassword);
      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    try {
      await deleteAccountUseCase();
      emit(AccountDeleted());
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(ProfileLoggedOut());
  }

  
}


