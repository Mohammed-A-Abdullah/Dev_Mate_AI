import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HomeQuickToolEntity> quickTools;
  final List<String>
  recentActivities; // Replace String with your actual ActivityEntity later

  HomeLoaded({required this.quickTools, required this.recentActivities});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
