class ReadmeGenerationException implements Exception {
  final String message;
  const ReadmeGenerationException(this.message);

  @override
  String toString() => message;
}
