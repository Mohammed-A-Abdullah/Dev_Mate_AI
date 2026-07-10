class ChatMessage {
  final String text;
  final bool isUser;
  bool expanded;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.expanded = false,
  });

  ChatMessage copyWith({String? text, bool? isUser, bool? expanded}) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      expanded: expanded ?? this.expanded,
    );
  }
}

