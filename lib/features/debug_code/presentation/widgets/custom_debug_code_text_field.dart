import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CustomDebugCodeTextField extends StatelessWidget {
  const CustomDebugCodeTextField({super.key, required this.errorLogController});
  final TextEditingController errorLogController;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
                controller: errorLogController,
                label: 'Debug & Error Instructions (Optional)',
                minLine: 1,
                maxLines: 3,
                keyBoardType: TextInputType.multiline,
                hintText:
                    'Provide any specific instructions or context for debugging the code.',
                prefixIcon: const Icon(
                  Icons.edit_note,
                ),
                radius: 18.r,
              );
  }
}