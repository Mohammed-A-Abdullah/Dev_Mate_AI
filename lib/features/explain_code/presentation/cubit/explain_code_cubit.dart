import 'package:dev_mate_ai/features/explain_code/domain/entity/explain_code_entity.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/explain_code_use_case.dart';

class ExplainCubit extends Cubit<ExplainCodeState> {
  final ExplainCodeUseCase explainCodeUseCase;

  ExplainCubit({required this.explainCodeUseCase})
    : super(const ExplainCodeState());

  // UI state mutations
  void updateLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void updateCode(String code) {
    emit(state.copyWith(code: code));
  }

  void updateAdditionalInstructions(String instructions) {
    emit(state.copyWith(additionalInstructions: instructions));
  }

  // Submit explain request
  Future<void> submitExplain() async {
    if (state.code.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter some code to explain.'));
      return;
    }

    emit(
      state.copyWith(isLoading: true, explanation: null, errorMessage: null),
    );

    try {
      final request = ExplainCodeEntity(
        language: state.language,
        code: state.code,
        additionalInstructions: state.additionalInstructions.trim().isEmpty
            ? null
            : state.additionalInstructions,
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

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
