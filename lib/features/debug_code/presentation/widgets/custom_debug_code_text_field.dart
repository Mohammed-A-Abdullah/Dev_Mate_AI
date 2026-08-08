import 'package:flutter/material.dart';

class CustomDebugCodeTextField extends StatelessWidget {
  const CustomDebugCodeTextField({
    super.key,
    required this.errorLogController,
    this.onChanged,
    this.maxLines = 3,
  });

  final TextEditingController errorLogController;

  final ValueChanged<String>? onChanged;

  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: errorLogController,

      maxLines: maxLines,

      minLines: 1,

      onChanged: onChanged,

      keyboardType: TextInputType.multiline,

      textInputAction: TextInputAction.newline,

      style: const TextStyle(fontSize: 14),

      decoration: InputDecoration(
        hintText: 'Paste error log here...',

        hintStyle: TextStyle(color: theme.hintColor, fontSize: 14),

        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: Icon(Icons.error_outline),
        ),

        prefixIconConstraints: const BoxConstraints(minWidth: 48),

        filled: true,

        fillColor:
            theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
