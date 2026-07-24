import 'package:bloc/bloc.dart';
import 'package:dev_mate_ai/features/splash/domain/usecases/is_authentecated_use_case.dart';
import '../../domain/usecases/check_onboarding.dart';
import '../../domain/usecases/save_onboarding_completed.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckOnboarding checkOnboarding;
  final SaveOnboardingCompleted saveOnboardingCompleted;
  final IsAuthentecatedUseCase isAuthentecatedUseCase;

  SplashCubit(this.checkOnboarding, this.saveOnboardingCompleted, {required this.isAuthentecatedUseCase})
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
    final authenticated = await isAuthentecatedUseCase();

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
