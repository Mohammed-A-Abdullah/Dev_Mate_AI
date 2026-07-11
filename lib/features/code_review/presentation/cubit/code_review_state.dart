import 'package:equatable/equatable.dart';

class CodeReviewState extends Equatable {
  final String language;
  final String code;
  final List<String> reviewTypes;
  final String experienceLevel;
  final String reviewDepth;
  final String errorLog;
  final bool isLoading;
  final String? reviewResult;
  final String? errorMessage;

  const CodeReviewState({
    this.language = 'Dart',
    this.code = '',
    this.reviewTypes = const [],
    this.experienceLevel = 'Beginner',
    this.reviewDepth = 'Quick Review',
    this.errorLog = '',
    this.isLoading = false,
    this.reviewResult,
    this.errorMessage,
  });

  CodeReviewState copyWith({
    String? language,
    String? code,
    List<String>? reviewTypes,
    String? experienceLevel,
    String? reviewDepth,
    String? errorLog,
    bool? isLoading,
    String? reviewResult,
    String? errorMessage,
  }) {
    return CodeReviewState(
      language: language ?? this.language,
      code: code ?? this.code,
      reviewTypes: reviewTypes ?? this.reviewTypes,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      reviewDepth: reviewDepth ?? this.reviewDepth,
      errorLog: errorLog ?? this.errorLog,
      isLoading: isLoading ?? this.isLoading,
      reviewResult: reviewResult ?? this.reviewResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    language,
    code,
    reviewTypes,
    experienceLevel,
    reviewDepth,
    errorLog,
    isLoading,
    reviewResult,
    errorMessage,
  ];
}
