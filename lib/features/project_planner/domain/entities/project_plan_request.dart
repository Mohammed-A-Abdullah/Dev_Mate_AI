class ProjectPlanRequest {
  final String title;
  final String description;
  final String platform;
  final String programmingLanguage;
  final String experienceLevel;
  final String architecture;
  final String deadline;
  final String deploymentTarget;

  ProjectPlanRequest({
    required this.title,
    required this.description,
    required this.platform,
    required this.programmingLanguage,
    required this.experienceLevel,
    required this.architecture,
    required this.deadline,
    required this.deploymentTarget,
  });
}
