import 'package:equatable/equatable.dart';

class ReadmeState extends Equatable {
  final String projectTitle;
  final String projectDescription;
  final String projectType;
  final List<String> features;
  final List<String> technologies;
  final String githubLink;
  final bool isLoading;
  final String? readmeResult;
  final String? errorMessage;

  const ReadmeState({
    this.projectTitle = '',
    this.projectDescription = '',
    this.projectType = 'Other',
    this.features = const [],
    this.technologies = const [],
    this.githubLink = '',
    this.isLoading = false,
    this.readmeResult,
    this.errorMessage,
  });

  ReadmeState copyWith({
    String? projectTitle,
    String? projectDescription,
    String? projectType,
    List<String>? features,
    List<String>? technologies,
    String? githubLink,
    bool? isLoading,
    String? readmeResult,
    String? errorMessage,
  }) {
    return ReadmeState(
      projectTitle: projectTitle ?? this.projectTitle,
      projectDescription: projectDescription ?? this.projectDescription,
      projectType: projectType ?? this.projectType,
      features: features ?? this.features,
      technologies: technologies ?? this.technologies,
      githubLink: githubLink ?? this.githubLink,
      isLoading: isLoading ?? this.isLoading,
      readmeResult: readmeResult,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    projectTitle,
    projectDescription,
    projectType,
    features,
    technologies,
    githubLink,
    isLoading,
    readmeResult,
    errorMessage,
  ];
}
