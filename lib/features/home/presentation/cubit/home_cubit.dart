import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/home_quick_tools_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeQuickToolsRepository repository})
    : _repository = repository,
      super(const HomeInitial());

  final HomeQuickToolsRepository _repository;

  Future<void> loadHomeData() async {
    emit(const HomeLoading());

    try {
      final tools = await _repository.getHomeQuickTools();
      emit(HomeLoaded(quickTools: tools,));
    } catch (e) {
      emit(HomeError('Failed to load dashboard data: $e'));
    }
  }
}
