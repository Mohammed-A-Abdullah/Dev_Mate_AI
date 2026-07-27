import 'package:flutter/material.dart';

class CustomDebugCodeTextField extends StatelessWidget {
  const CustomDebugCodeTextField({
    super.key,
    required this.errorLogController,
    this.onChanged,
  });

  final TextEditingController errorLogController;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: errorLogController,
      maxLines: 2,
      onChanged: onChanged,
      decoration: const InputDecoration(hintText: 'Paste error log here...'),
    );
  }
}
