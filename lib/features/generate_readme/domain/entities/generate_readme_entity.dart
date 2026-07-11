class GenerateReadmeEntity {
  final String projectTitle;
  final String projectDescription;
  final String projectType;
  final List<String> features;
  final List<String> technologies;
  final String? githubLink;

  GenerateReadmeEntity({
    required this.projectTitle,
    required this.projectDescription,
    required this.projectType,
    required this.features,
    required this.technologies,
    this.githubLink,
  });
}
