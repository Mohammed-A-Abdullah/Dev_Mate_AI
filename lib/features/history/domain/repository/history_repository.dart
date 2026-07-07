import 'package:dev_mate_ai/features/history/domain/entity/history_entity.dart';

abstract class HistoryRepository {
  Future<HistoryEntity> getHistoryCardContent();
}