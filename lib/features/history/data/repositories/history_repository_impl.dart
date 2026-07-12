import '../../domain/entity/history_entity.dart';
import '../../domain/repository/history_repository.dart';
import '../datasource/history_remote_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remote;

  HistoryRepositoryImpl(this.remote);

  @override
  Future<List<HistoryEntity>> getHistory() {
    return remote.getHistory();
  }
}
