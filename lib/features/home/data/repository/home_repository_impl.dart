import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';
import 'package:dev_mate_ai/features/home/domain/entities/home_tool_type.dart';
import 'package:dev_mate_ai/features/home/domain/repository/home_quick_tools_repository.dart';

class HomeRepositoryImpl implements HomeQuickToolsRepository {
  @override
  Future<List<HomeQuickToolEntity>> getHomeQuickTools() async {
    return const [
      HomeQuickToolEntity(
        type: HomeToolType.explainCode,
      ),
      HomeQuickToolEntity(
        type: HomeToolType.debugCode,
      ),
      HomeQuickToolEntity(
        type: HomeToolType.generateReadme,
      ),
      HomeQuickToolEntity(
        type: HomeToolType.projectPlanner,
      ),
      HomeQuickToolEntity(
        type: HomeToolType.aiChat,
      ),
      HomeQuickToolEntity(
        type: HomeToolType.codeReview,
      ),
    ];
  }
}
