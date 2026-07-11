import 'package:dev_mate_ai/features/code_review/domain/entities/code_review_request_entity.dart';
import 'package:dev_mate_ai/features/code_review/domain/usecases/code_review_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'code_review_state.dart';

class CodeReviewCubit extends Cubit<CodeReviewState> {
  final CodeReviewUseCase reviewCodeUseCase;

  CodeReviewCubit({required this.reviewCodeUseCase})
    : super(const CodeReviewState());

  void updateLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void updateCode(String code) {
    emit(state.copyWith(code: code));
  }

  void toggleReviewType(String type) {
    final List<String> current = List.from(state.reviewTypes);
    if (current.contains(type)) {
      current.remove(type);
    } else {
      current.add(type);
    }
    emit(state.copyWith(reviewTypes: current));
  }

  void updateExperienceLevel(String level) {
    emit(state.copyWith(experienceLevel: level));
  }

  void updateReviewDepth(String depth) {
    emit(state.copyWith(reviewDepth: depth));
  }

  void updateErrorLog(String log) {
    emit(state.copyWith(errorLog: log));
  }

  // Submit review
  Future<void> submitReview() async {
    if (state.code.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter some code to review.'));
      return;
    }

    if (state.reviewTypes.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please select at least one review focus.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(isLoading: true, reviewResult: null, errorMessage: null),
    );

    try {
      final request = CodeReviewRequestEntity(
        language: state.language,
        code: state.code,
        reviewTypes: state.reviewTypes,
        experienceLevel: state.experienceLevel,
        reviewDepth: state.reviewDepth,
        projectContext: state.errorLog.trim().isEmpty ? null : state.errorLog,
      );

      final result = await reviewCodeUseCase(request);
      emit(state.copyWith(isLoading: false, reviewResult: result));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to generate review: ${e.toString()}',
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
