import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/generate_readme_entity.dart';
import '../../domain/exceptions/readme_generation_exception.dart';
import '../../domain/usecases/generate_readme_use_case.dart';
import 'readme_state.dart';

class ReadmeCubit extends Cubit<ReadmeState> {
  final GenerateReadmeUseCase _generateReadmeUseCase;

  ReadmeCubit({required GenerateReadmeUseCase generateReadmeUseCase})
    : _generateReadmeUseCase = generateReadmeUseCase,
      super(const ReadmeState());

  void updateProjectType(String type) =>
      emit(state.copyWith(projectType: type));

  void addFeature(String feature) {
    final trimmed = feature.trim();
    if (trimmed.isEmpty || state.features.contains(trimmed)) return;
    emit(state.copyWith(features: [...state.features, trimmed]));
  }

  void removeFeature(String feature) {
    final updated = List<String>.from(state.features)..remove(feature);
    emit(state.copyWith(features: updated));
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

  Future<void> generateReadme({
    required String title,
    required String description,
    required String githubLink,
  }) async {
    emit(
      ReadmeState(
        isLoading: true,
        projectTitle: title,
        projectDescription: description,
        githubLink: githubLink,
        projectType: state.projectType,
        features: state.features,
        technologies: state.technologies,
        readmeResult: null,
        errorMessage: null,
      ),
    );

    try {
      final entity = GenerateReadmeEntity(
        projectTitle: title,
        projectDescription: description,
        projectType: state.projectType,
        features: state.features,
        technologies: state.technologies,
        githubLink: githubLink,
      );

      final result = await _generateReadmeUseCase(entity);
      emit(state.copyWith(isLoading: false, readmeResult: result));
    } on ReadmeGenerationException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
}
