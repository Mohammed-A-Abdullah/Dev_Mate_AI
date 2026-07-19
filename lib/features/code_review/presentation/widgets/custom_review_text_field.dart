import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CustomReviewTextField extends StatelessWidget {
  const CustomReviewTextField({super.key, required this.errorLogController});
final TextEditingController errorLogController;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
                controller: errorLogController,
                label: 'Project Context (Optional)',
                minLine: 1,
                maxLines: 3,
                keyBoardType: TextInputType.multiline,
                hintText:
                    'ex: This is a login screen using Firebase Authentication....',
                prefixIcon: const Icon(
                  Icons.edit_note,
                ),
                radius: 18.r,
              );
  }
}