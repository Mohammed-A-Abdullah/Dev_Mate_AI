import '../../domain/entity/history_entity.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> history;

  HistoryLoaded(this.history);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
