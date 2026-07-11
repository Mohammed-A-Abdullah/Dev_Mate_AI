import 'package:equatable/equatable.dart';

class ExplainCodeState extends Equatable {
  final String language;
  final String code;
  final String additionalInstructions;
  final bool isLoading;
  final String? explanation;
  final String? errorMessage;

  const ExplainCodeState({
    this.language = 'Dart',
    this.code = '',
    this.additionalInstructions = '',
    this.isLoading = false,
    this.explanation,
    this.errorMessage,
  });

  ExplainCodeState copyWith({
    String? language,
    String? code,
    String? additionalInstructions,
    bool? isLoading,
    String? explanation,
    String? errorMessage,
  }) {
    return ExplainCodeState(
      language: language ?? this.language,
      code: code ?? this.code,
      additionalInstructions:
          additionalInstructions ?? this.additionalInstructions,
      isLoading: isLoading ?? this.isLoading,
      explanation: explanation ?? this.explanation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    language,
    code,
    additionalInstructions,
    isLoading,
    explanation,
    errorMessage,
  ];
}
