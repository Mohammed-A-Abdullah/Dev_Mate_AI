class ChatMessage {
  final String text;
  final bool isUser;
  bool expanded;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.expanded = false,
  });
}
