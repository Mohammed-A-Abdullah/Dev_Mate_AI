import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomProjectPlannerTextField extends StatelessWidget {
  const CustomProjectPlannerTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.description,
  });
  final TextEditingController controller;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: title,
      keyBoardType: TextInputType.multiline,
      hintText: description,
      prefixIcon: const Icon(Icons.edit_note),
    );
  }
}
