import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CostomReadmeTextField extends StatelessWidget {
  const CostomReadmeTextField({this.icon=Icons.edit_note, super.key, required this.controller, required this.title, required this.description});
final TextEditingController controller;
final String title;
final String description;
final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
                controller: controller,
                label: title,
                keyBoardType: TextInputType.multiline,
                hintText: description,
                prefixIcon:  Icon(
                  icon ??Icons.edit_note,
                ),
              );
  }
}