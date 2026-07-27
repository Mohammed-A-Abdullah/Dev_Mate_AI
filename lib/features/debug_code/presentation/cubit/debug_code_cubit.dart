import 'package:dev_mate_ai/features/debug_code/domain/entities/debug_code_request_entity.dart';
import 'package:dev_mate_ai/features/debug_code/domain/usecase/debug_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'debug_code_state.dart';

class DebugCubit extends Cubit<DebugState> {
  final DebugCodeUseCase debugCodeUseCase;

  DebugCubit({required this.debugCodeUseCase}) : super(const DebugState());

  void updateLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void updateCode(String code) {
    emit(state.copyWith(code: code));
  }

  void updateErrorLog(String log) {
    emit(state.copyWith(errorLog: log));
  }

  Future<void> submitDebug() async {
    if (state.code.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter some code to debug.'));
      return;
    }

    emit(
      state.copyWith(isLoading: true, debugResult: null, errorMessage: null),
    );

    try {
      final request = DebugCodeRequestEntity(
        language: state.language,
        code: state.code,
        debugContext: state.errorLog.trim().isEmpty ? null : state.errorLog,
      );

      final result = await debugCodeUseCase(request);

      emit(state.copyWith(isLoading: false, debugResult: result));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to debug code: ${e.toString()}',
        ),
      );
    }
  }
  void clearResult() {
    emit(state.copyWith(debugResult: null));
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
