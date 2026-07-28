import 'package:dev_mate_ai/features/explain_code/domain/entity/explain_code_entity.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/explain_code_use_case.dart';

class ExplainCubit extends Cubit<ExplainCodeState> {
  final ExplainCodeUseCase explainCodeUseCase;

  ExplainCubit({required this.explainCodeUseCase})
    : super(const ExplainCodeState());

  void updateLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  Future<void> submitExplain({
    required String code,
    required String additionalInstructions,
  }) async {
    final trimmedCode = code.trim();
    if (trimmedCode.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter some code to explain.'));
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        clearExplanation: true, // استخدام الـ flag
        clearError: true, // استخدام الـ flag
        code: trimmedCode,
        additionalInstructions: additionalInstructions,
      ),
    );

    try {
      final request = ExplainCodeEntity(
        language: state.language,
        code: trimmedCode,
        additionalInstructions: additionalInstructions.trim().isEmpty
            ? null
            : additionalInstructions.trim(),
      );

      final result = await explainCodeUseCase(request);
      emit(state.copyWith(isLoading: false, explanation: result));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to explain code: ${e.toString()}',
        ),
      );
    }
  }

  void resetExplanation() {
    emit(state.copyWith(clearExplanation: true));
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }
}
