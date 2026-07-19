import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'custom_code_element_builder.dart';

class CustomMarkdownBody extends StatelessWidget {
  const CustomMarkdownBody({super.key, required this.inputData});
  final String inputData;
  @override
  Widget build(BuildContext context) {
    final colorTheme=Theme.of(context).colorScheme;
    return MarkdownBody(
                                  data: inputData,
                                  selectable: true,
                                  styleSheet: MarkdownStyleSheet(
                                    p:  TextStyle(
                                      color: colorTheme.surface,
                                      fontSize: 15,
                                    ),
                                    h1:  TextStyle(
                                      color: colorTheme.surface,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    h2:  TextStyle(
                                      color: colorTheme.surface,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    h3:  TextStyle(
                                      color: colorTheme.surface,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    listBullet:  TextStyle(
                                      color: colorTheme.surface,
                                    ),
                                    strong:  TextStyle(
                                      color: colorTheme.surface,
                                      fontWeight: FontWeight.bold,
                                    ),

                                    code: const TextStyle(
                                      backgroundColor: Colors.transparent,
                                    ),
                                    codeblockDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  builders: {'code': CustomCodeElementBuilder()},
                                );
  }
}