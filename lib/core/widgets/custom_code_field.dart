import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';

class CustomCodeEditor extends StatelessWidget {
  const CustomCodeEditor({
    super.key,
    required this.controller,
    this.height,
    this.onChanged,
  });

  final CodeLineEditingController controller;
  final double? height;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF282C34) : const Color(0xFFFAFAFA);
    final borderColor = isDark
        ? const Color(0xFF1E2227)
        : const Color(0xFFE0E0E0);
    final cursorColor = isDark
        ? const Color(0xFF528BFF)
        : const Color(0xFF526FFF);
    final selectionColor = isDark
        ? const Color(0xFF3E4451)
        : const Color(0xFFCCE1FF);
    final textColor = isDark
        ? const Color(0xFFA6ACCD)
        : const Color(0xFF383A42);
    final gutterText = isDark
        ? const Color(0xFF5C6370)
        : const Color(0xFF9E9E9E);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: height ?? 350,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: CodeEditor(
          controller: controller,
          style: CodeEditorStyle(
            backgroundColor: bgColor,
            textColor: textColor,
            fontSize: 14,
            fontFamily: 'monospace',
            cursorColor: cursorColor,
            selectionColor: selectionColor,
          ),
          indicatorBuilder:
              (context, editingController, chunkController, notifier) {
                return DefaultCodeLineNumber(
                  controller: editingController,
                  notifier: notifier,
                  textStyle: TextStyle(
                    color: gutterText,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                );
              },
          onChanged: (value) {
            onChanged?.call(value.toString());
          },
        ),
      ),
    );
  }
}
