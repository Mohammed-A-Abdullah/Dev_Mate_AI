import 'package:flutter/material.dart';

class ChatThemeExtension extends ThemeExtension<ChatThemeExtension> {
  final Color chatBotMessage;
  final Color codeBackgound;

  const ChatThemeExtension({required this.chatBotMessage, required this.codeBackgound});

  @override
  ChatThemeExtension copyWith({Color? chatBotMessage}) {
    return ChatThemeExtension(
      chatBotMessage: chatBotMessage ?? this.chatBotMessage, codeBackgound: codeBackgound ,
    );
  }

  @override
  ChatThemeExtension lerp(
    covariant ThemeExtension<ChatThemeExtension>? other,
    double t,
  ) {
    if (other is! ChatThemeExtension) {
      return this;
    }

    return ChatThemeExtension(
      chatBotMessage:
          Color.lerp(chatBotMessage, other.chatBotMessage, t) ?? chatBotMessage, codeBackgound: Color.lerp(codeBackgound, other.codeBackgound, t)??codeBackgound,
    );
  }
}
