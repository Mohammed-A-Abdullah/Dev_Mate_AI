import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../splash/domain/usecases/save_onboarding_completed.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../constant/onboarding_const_data.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SaveOnboardingCompleted _saveOnboardingCompleted;
  final OnboardingConstData _data;

  late final List<OnboardingEntity> onboardingPages;

  OnboardingCubit(this._saveOnboardingCompleted, this._data)
    : super(const OnboardingState()) {
    onboardingPages = _data.getOnboardingPages();
  }

  Future<void> finishOnboarding() async {
    await _saveOnboardingCompleted();
    emit(OnboardingCompleted());
  }

  void onPageChanged(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
        isLastPage: index == onboardingPages.length - 1,
      ),
    );
  }
}
