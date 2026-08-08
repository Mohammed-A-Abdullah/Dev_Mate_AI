import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'custom_code_element_builder.dart';

class CustomMarkdownBody extends StatelessWidget {
  const CustomMarkdownBody({super.key, required this.inputData});
  final String inputData;
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final responseTextColor = colorTheme.onSurface;

    return MarkdownBody(
      data: inputData,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(color: responseTextColor, fontSize: 15),
        h1: TextStyle(
          color: responseTextColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        h2: TextStyle(
          color: responseTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        h3: TextStyle(
          color: responseTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        listBullet: TextStyle(color: responseTextColor),
        strong: TextStyle(
          color: responseTextColor,
          fontWeight: FontWeight.bold,
        ),
        em: TextStyle(color: responseTextColor),
        blockquote: TextStyle(color: responseTextColor),
        code: TextStyle(
          color: responseTextColor,
          backgroundColor: colorTheme.surface.withValues(alpha: 0.65),
        ),
        codeblockDecoration: BoxDecoration(
          color: colorTheme.surface.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      builders: {'code': CustomCodeElementBuilder()},
    );
  }
}
