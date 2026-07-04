import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';

abstract class HomeQuickToolsRepository {
  List<HomeQuickToolEntity> getHomeQuickTools();
}