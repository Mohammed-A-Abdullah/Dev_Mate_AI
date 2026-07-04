import 'package:dev_mate_ai/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/onboarding_entity.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository _repository;
  late final List<OnboardingEntity> onboardingPages;

  OnboardingCubit(this._repository) : super(const OnboardingState()) {
    onboardingPages = _repository.getOnboardingPages();
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
