import 'package:equatable/equatable.dart';

class DebugState extends Equatable {
  final String language;
  final String code;
  final String errorLog;
  final bool isLoading;
  final String? debugResult;
  final String? errorMessage;

  const DebugState({
    this.language = 'Dart',
    this.code = '',
    this.errorLog = '',
    this.isLoading = false,
    this.debugResult,
    this.errorMessage,
  });

  DebugState copyWith({
    String? language,
    String? code,
    String? errorLog,
    bool? isLoading,
    String? debugResult,
    String? errorMessage,
    bool clearResult = false, // لحل مشكلة تفريغ النتيجة
    bool clearError = false, // لحل مشكلة تفريغ الخطأ
  }) {
    return DebugState(
      language: language ?? this.language,
      code: code ?? this.code,
      errorLog: errorLog ?? this.errorLog,
      isLoading: isLoading ?? this.isLoading,
      debugResult: clearResult ? null : (debugResult ?? this.debugResult),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    language,
    code,
    errorLog,
    isLoading,
    debugResult,
    errorMessage,
  ];
}
