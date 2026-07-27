import 'package:equatable/equatable.dart';

class GenerateReadmeEntity extends Equatable {
  final String projectTitle;
  final String projectDescription;
  final String projectType;
  final List<String> features;
  final List<String> technologies;
  final String? githubLink;

  const GenerateReadmeEntity({
    required this.projectTitle,
    required this.projectDescription,
    required this.projectType,
    required this.features,
    required this.technologies,
    this.githubLink,
  });

  @override
  List<Object?> get props => [
    projectTitle,
    projectDescription,
    projectType,
    features,
    technologies,
    githubLink,
  ];
}
