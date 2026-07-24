class OnboardingState {
  final int currentIndex;
  final bool isLastPage;

  const OnboardingState({this.currentIndex = 0, this.isLastPage = false});

  OnboardingState copyWith({int? currentIndex, bool? isLastPage}) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
