import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'custom_code_element_builder.dart';

class CustomMarkdownBody extends StatelessWidget {
  const CustomMarkdownBody({super.key, required this.inputData});
  final String inputData;
  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
                                  data: inputData,
                                  selectable: true,
                                  styleSheet: MarkdownStyleSheet(
                                    p: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    h1: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    h2: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    h3: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    listBullet: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    strong: const TextStyle(
                                      color: Colors.white,
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