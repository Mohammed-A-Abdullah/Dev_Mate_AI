class ProjectPlanException implements Exception {
  final String message;
  const ProjectPlanException(this.message);

  @override
  String toString() => message;
}
