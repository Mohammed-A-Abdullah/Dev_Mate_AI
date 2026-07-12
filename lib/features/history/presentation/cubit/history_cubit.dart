import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_history_use_case.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;

  HistoryCubit(this.getHistoryUseCase) : super(HistoryInitial());

  Future<void> loadHistory() async {
    emit(HistoryLoading());

    try {
      final history = await getHistoryUseCase();
      //=========================================================
      print(history);

      emit(HistoryLoaded(history));
    } catch (e) {
      print("❌ Error loading history: $e");
      emit(HistoryError(e.toString()));
    }
  }
}
