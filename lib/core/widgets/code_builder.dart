import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    bool isBlock = element.textContent.contains('\n');
    String language = '';
    if (element.attributes['class'] != null) {
      String className = element.attributes['class'] as String;
      language = className.replaceFirst('language-', '');
    }
    if (!isBlock) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          element.textContent,
          style: const TextStyle(
            color: Color(0xffB5C4ff),
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
      );
    }

    Map<String, TextStyle> customTheme = Map.from(atomOneDarkTheme);
    customTheme['root'] = TextStyle(
      color: customTheme['root']?.color ?? const Color(0xffabb2bf),
      backgroundColor: Colors.transparent,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff0D0D12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // lang-name && copy
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: const BoxDecoration(
              color: Color(0xff1A1C23),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language.isEmpty ? 'code' : language,
                  style: const TextStyle(
                    color: Color(0xff8B8E98),
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: element.textContent));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.copy, size: 14, color: Color(0xff8B8E98)),
                      SizedBox(width: 4),
                      Text(
                        "Copy",
                        style: TextStyle(
                          color: Color(0xff8B8E98),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: HighlightView(
                  element.textContent.trim(),
                  language: language.isEmpty ? 'dart' : language,
                  theme: customTheme,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
