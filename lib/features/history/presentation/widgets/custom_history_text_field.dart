import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CustomHistoryTextField extends StatelessWidget {
  const CustomHistoryTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: S.of(context).searchHistory,
      prefixIcon: const Icon(Icons.search, size: 20),
      radius: 50,
      hintTextStyle: TextStyle(
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        fontWeight: FontWeight.w400,
      ),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}
