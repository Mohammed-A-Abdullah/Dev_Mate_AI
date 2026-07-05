import 'package:bloc/bloc.dart';

import '../../../../core/services/app_preferences.dart';
import '../../domain/usecases/check_onboarding.dart';
import '../../domain/usecases/save_onboarding_completed.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckOnboarding checkOnboarding;
  final SaveOnboardingCompleted saveOnboardingCompleted;

  SplashCubit(this.checkOnboarding, this.saveOnboardingCompleted)
    : super(SplashInitial());

  Future<void> start() async {
    await Future.delayed(const Duration(seconds: 6));
    await _routeBasedOnPersistedState();
  }

  Future<void> finishOnboarding() async {
    await saveOnboardingCompleted();
    await _routeBasedOnPersistedState();
  }

  Future<void> _routeBasedOnPersistedState() async {
    final onboardingCompleted = await checkOnboarding();
    final authenticated = await AppPreferences.isAuthenticated();

    if (!onboardingCompleted) {
      emit(SplashGoToOnboarding());
      return;
    }

    if (!authenticated) {
      emit(SplashGoToAuth());
      return;
    }

    emit(SplashGoToChat());
  }
}
