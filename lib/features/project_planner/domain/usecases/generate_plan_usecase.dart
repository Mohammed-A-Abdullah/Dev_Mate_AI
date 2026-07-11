import '../entities/project_plan_request.dart';
import '../repositories/i_project_plan_repository.dart';

class GeneratePlanUseCase {
  final IProjectPlanRepository repository;

  GeneratePlanUseCase(this.repository);

  Future<String> call(ProjectPlanRequest request) {
    return repository.generatePlan(request);
  }
}
