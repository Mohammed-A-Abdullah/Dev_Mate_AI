import 'package:dev_mate_ai/core/theme/extensions/chat_theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_markdown_body.dart';

class CustomUserAndBotMessage extends StatelessWidget {
  const CustomUserAndBotMessage({
    super.key,
    required this.check,
    required this.text,
    this.onTap,
  });
  final bool check;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final chatExtension = Theme.of(context).extension<ChatThemeExtension>();
    return Align(
      alignment: check ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(14),
          constraints: BoxConstraints(
            maxWidth: check
                ? MediaQuery.of(context).size.width * .75
                : MediaQuery.of(context).size.width * .90,
          ),
          decoration: BoxDecoration(
            color: check ? colorTheme.primary : chatExtension!.chatBotMessage,
            borderRadius: BorderRadius.circular(18),
            border: check ? null : Border.all(color: colorTheme.outline),
          ),
          child: check
              ? Text(
                  text,
                  style: TextStyle(color: colorTheme.onPrimary, fontSize: 16),
                )
              : CustomMarkdownBody(inputData: text),
        ),
      ),
    );
  }
}
