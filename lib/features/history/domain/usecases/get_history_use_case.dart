import '../entity/history_entity.dart';
import '../repository/history_repository.dart';

class GetHistoryUseCase {
  final HistoryRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<HistoryEntity>> call() {
    return repository.getHistory();
  }
}
