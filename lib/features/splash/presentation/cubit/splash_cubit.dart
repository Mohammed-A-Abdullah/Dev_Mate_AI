import 'package:bloc/bloc.dart';

import '../../../../core/services/app_preferences.dart';
import '../../domain/usecases/check_onboarding.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckOnboarding checkOnboarding;

  SplashCubit(this.checkOnboarding) : super(SplashInitial());

  Future<void> start() async {
    await Future.delayed(const Duration(seconds: 2));

    final completed = await checkOnboarding();
    final authenticated = await AppPreferences.isAuthenticated();

    if (!completed) {
      emit(SplashGoToOnboarding());
    } else if (!authenticated) {
      emit(SplashGoToAuth());
    } else {
      emit(SplashGoToChat());
    }
  }
}
