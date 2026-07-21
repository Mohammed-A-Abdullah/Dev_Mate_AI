import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useccases/logout_use_case.dart';
import '../../domain/useccases/get_profile_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit(this.getProfileUseCase, this.logoutUseCase)
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

  Future<void> logout() async {
    await logoutUseCase();

    emit(ProfileLoggedOut());
  }
}
