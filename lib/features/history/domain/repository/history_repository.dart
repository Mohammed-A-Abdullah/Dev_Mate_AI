import '../entity/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistory();
}
