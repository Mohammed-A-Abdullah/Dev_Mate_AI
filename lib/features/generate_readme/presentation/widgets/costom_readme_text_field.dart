import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CostomReadmeTextField extends StatelessWidget {
  const CostomReadmeTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.description,
    this.icon = Icons.edit_note,
  });

  final TextEditingController controller;
  final String title;
  final String description;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: title,
      maxLines: 1,
      keyBoardType: TextInputType.text,
      hintText: description,
      prefixIcon: Icon(icon ?? Icons.edit_note),
      radius: 16.0,
    );
  }
}
