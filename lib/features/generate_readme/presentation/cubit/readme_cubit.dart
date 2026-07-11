import 'package:dev_mate_ai/features/generate_readme/domain/entities/generate_readme_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/generate_readme_use_case.dart';
import 'readme_state.dart';

class ReadmeCubit extends Cubit<ReadmeState> {
  final GenerateReadmeUseCase generateReadmeUseCase;

  ReadmeCubit({required this.generateReadmeUseCase})
    : super(const ReadmeState());

  void updateProjectTitle(String title) {
    emit(state.copyWith(projectTitle: title));
  }

  void updateProjectDescription(String description) {
    emit(state.copyWith(projectDescription: description));
  }

  void updateProjectType(String type) {
    emit(state.copyWith(projectType: type));
  }

  void addFeature(String feature) {
    final trimmed = feature.trim();
    if (trimmed.isEmpty || state.features.contains(trimmed)) return;
    final newList = List<String>.from(state.features)..add(trimmed);
    emit(state.copyWith(features: newList));
  }

  void removeFeature(String feature) {
    final newList = List<String>.from(state.features)..remove(feature);
    emit(state.copyWith(features: newList));
  }

  void toggleTechnology(String tech) {
    final current = List<String>.from(state.technologies);
    if (current.contains(tech)) {
      current.remove(tech);
    } else {
      current.add(tech);
    }
    emit(state.copyWith(technologies: current));
  }

  void updateGithubLink(String link) {
    emit(state.copyWith(githubLink: link));
  }

  Future<void> generateReadme() async {
    if (state.projectTitle.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please provide a project title.'));
      return;
    }

    if (state.projectDescription.trim().isEmpty) {
      emit(
        state.copyWith(errorMessage: 'Please provide a project description.'),
      );
      return;
    }

    emit(
      state.copyWith(isLoading: true, readmeResult: null, errorMessage: null),
    );

    try {
      final request = GenerateReadmeEntity(
        projectTitle: state.projectTitle,
        projectDescription: state.projectDescription,
        projectType: state.projectType,
        features: state.features,
        technologies: state.technologies,
        githubLink: state.githubLink.trim().isEmpty ? null : state.githubLink,
      );

      final result = await generateReadmeUseCase(request);
      emit(state.copyWith(isLoading: false, readmeResult: result));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to generate README: ${e.toString()}',
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
