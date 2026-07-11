import '../entities/project_plan_request.dart';

abstract class IProjectPlanRepository {
  Future<String> generatePlan(ProjectPlanRequest request);
}
