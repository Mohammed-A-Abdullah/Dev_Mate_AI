class CodeReviewRequestEntity {
  final String language;
  final String code;
  final List<String> reviewTypes;
  final String experienceLevel;
  final String reviewDepth;
  final String? projectContext;

  CodeReviewRequestEntity({
    required this.language,
    required this.code,
    required this.reviewTypes,
    required this.experienceLevel,
    required this.reviewDepth,
    this.projectContext,
  });
}
