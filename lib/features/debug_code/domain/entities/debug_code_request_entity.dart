class DebugCodeRequestEntity {
  final String language;
  final String code;
  final String? debugContext;

  DebugCodeRequestEntity({required this.language, required this.code,this.debugContext});
}