import 'package:dev_mate_ai/features/history/domain/entity/history_entity.dart';
import 'package:dev_mate_ai/features/history/domain/repository/history_repository.dart';

class HistoryUseCase {
final HistoryRepository response;

  HistoryUseCase({required this.response});
Future<HistoryEntity>call(){
  return response.getHistoryCardContent();
}
}