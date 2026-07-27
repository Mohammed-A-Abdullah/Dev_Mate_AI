import 'package:equatable/equatable.dart';

class ProjectPlanRequest extends Equatable {
  final String title;
  final String description;
  final String platform;
  final String programmingLanguage;
  final String experienceLevel;
  final String architecture;
  final String deadline;
  final String deploymentTarget;

  const ProjectPlanRequest({
    required this.title,
    required this.description,
    required this.platform,
    required this.programmingLanguage,
    required this.experienceLevel,
    required this.architecture,
    required this.deadline,
    required this.deploymentTarget,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    platform,
    programmingLanguage,
    experienceLevel,
    architecture,
    deadline,
    deploymentTarget,
  ];
}
