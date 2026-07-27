import 'package:equatable/equatable.dart';

class CodeReviewState extends Equatable {
  final String language;
  final List<String> reviewTypes;
  final String experienceLevel;
  final String reviewDepth;
  final bool isLoading;
  final String? reviewResult;
  final String? errorMessage;

  const CodeReviewState({
    this.language = 'Dart',
    this.reviewTypes = const [],
    this.experienceLevel = 'Beginner',
    this.reviewDepth = 'Quick Review',
    this.isLoading = false,
    this.reviewResult,
    this.errorMessage,
  });

  CodeReviewState copyWith({
    String? language,
    List<String>? reviewTypes,
    String? experienceLevel,
    String? reviewDepth,
    bool? isLoading,
    String? reviewResult,
    String? errorMessage,
  }) {
    return CodeReviewState(
      language: language ?? this.language,
      reviewTypes: reviewTypes ?? this.reviewTypes,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      reviewDepth: reviewDepth ?? this.reviewDepth,
      isLoading: isLoading ?? this.isLoading,
      reviewResult: reviewResult,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    language,
    reviewTypes,
    experienceLevel,
    reviewDepth,
    isLoading,
    reviewResult,
    errorMessage,
  ];
}
