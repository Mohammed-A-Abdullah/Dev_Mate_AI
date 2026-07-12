class HistoryEntity {
  final String id;
  final String title;
  final String lastMessage;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int messageCount;

  const HistoryEntity({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.messageCount,
  });
}
