import 'package:equatable/equatable.dart';

class ProjectPlanState extends Equatable {
  final String platform;
  final String programmingLanguage;
  final String experienceLevel;
  final String architecture;
  final String deadline;
  final String deploymentTarget;
  final bool isLoading;
  final String? planResult;
  final String? errorMessage;

  const ProjectPlanState({
    this.platform = 'Flutter (Mobile)',
    this.programmingLanguage = 'Dart',
    this.experienceLevel = 'Beginner',
    this.architecture = 'Clean Architecture',
    this.deadline = 'No deadline',
    this.deploymentTarget = 'Android',
    this.isLoading = false,
    this.planResult,
    this.errorMessage,
  });

  ProjectPlanState copyWith({
    String? platform,
    String? programmingLanguage,
    String? experienceLevel,
    String? architecture,
    String? deadline,
    String? deploymentTarget,
    bool? isLoading,
    String? planResult,
    String? errorMessage,
  }) {
    return ProjectPlanState(
      platform: platform ?? this.platform,
      programmingLanguage: programmingLanguage ?? this.programmingLanguage,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      architecture: architecture ?? this.architecture,
      deadline: deadline ?? this.deadline,
      deploymentTarget: deploymentTarget ?? this.deploymentTarget,
      isLoading: isLoading ?? this.isLoading,
      planResult: planResult,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    platform,
    programmingLanguage,
    experienceLevel,
    architecture,
    deadline,
    deploymentTarget,
    isLoading,
    planResult,
    errorMessage,
  ];
}
