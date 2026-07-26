import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final List<HomeQuickToolEntity> quickTools;

  const HomeLoaded({required this.quickTools,});
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
