import 'package:flutter_bloc/flutter_bloc.dart';
import 'project_plan_state.dart';
import '../../domain/entities/project_plan_request.dart';
import '../../domain/usecases/generate_plan_usecase.dart';

class ProjectPlanCubit extends Cubit<ProjectPlanState> {
  final GeneratePlanUseCase generatePlanUseCase;

  ProjectPlanCubit({required this.generatePlanUseCase})
    : super(const ProjectPlanState());

  void updatePlatform(String platform) =>
      emit(state.copyWith(platform: platform));
  void updateProgrammingLanguage(String language) =>
      emit(state.copyWith(programmingLanguage: language));
  void updateExperienceLevel(String level) =>
      emit(state.copyWith(experienceLevel: level));
  void updateArchitecture(String architecture) =>
      emit(state.copyWith(architecture: architecture));
  void updateDeadline(String deadline) =>
      emit(state.copyWith(deadline: deadline));
  void updateDeploymentTarget(String target) =>
      emit(state.copyWith(deploymentTarget: target));

  Future<void> generatePlan({
    required String title,
    required String description,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedDesc = description.trim();

    if (trimmedTitle.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please provide a project title.',
          planResult: null,
        ),
      );
      return;
    }

    if (trimmedDesc.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please provide a project description.',
          planResult: null,
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, planResult: null, errorMessage: null));

    try {
      final request = ProjectPlanRequest(
        title: trimmedTitle,
        description: trimmedDesc,
        platform: state.platform,
        programmingLanguage: state.programmingLanguage,
        experienceLevel: state.experienceLevel,
        architecture: state.architecture,
        deadline: state.deadline,
        deploymentTarget: state.deploymentTarget,
      );

      final result = await generatePlanUseCase(request);
      emit(state.copyWith(isLoading: false, planResult: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
