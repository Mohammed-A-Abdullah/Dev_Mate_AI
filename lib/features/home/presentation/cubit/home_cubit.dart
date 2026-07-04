import 'package:dev_mate_ai/features/home/domain/repository/home_quick_tools_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeQuickToolsRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final tools = _repository.getHomeQuickTools();
      final activities = [
        'Refactored AuthBloc',
        'Generated API Models',
      ];

      emit(HomeLoaded(quickTools: tools, recentActivities: activities));
    } catch (e) {
      emit(HomeError(message: 'Failed to load dashboard data: $e'));
    }
  }
}
