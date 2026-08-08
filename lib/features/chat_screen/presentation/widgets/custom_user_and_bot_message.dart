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

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Use a percentage of the available space, but cap it with an
        // absolute pixel limit so bubbles don't stretch unreasonably wide
        // on tablets/desktop.
        final maxBubbleWidth = check
            ? (availableWidth * .75).clamp(0.0, 420.0)
            : (availableWidth * .90).clamp(0.0, 640.0);

        return Align(
          alignment: check ? Alignment.centerRight : Alignment.centerLeft,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(14),
              constraints: BoxConstraints(maxWidth: maxBubbleWidth),
              decoration: BoxDecoration(
                color: check
                    ? colorTheme.primary
                    : chatExtension!.chatBotMessage,
                borderRadius: BorderRadius.circular(18),
                border: check ? null : Border.all(color: colorTheme.outline),
              ),
              child: check
                  ? Text(
                      text,
                      style: TextStyle(
                        color: colorTheme.onPrimary,
                        fontSize: 16,
                      ),
                    )
                  : CustomMarkdownBody(inputData: text),
            ),
          ),
        );
      },
    );
  }
}
