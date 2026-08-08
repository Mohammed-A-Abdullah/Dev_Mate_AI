import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomReviewTextField extends StatelessWidget {
  const CustomReviewTextField({super.key, required this.errorLogController});

  final TextEditingController errorLogController;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    final width = MediaQuery.sizeOf(context).width;

    final isDesktop = width >= 1024;

    return CustomTextField(
      controller: errorLogController,

      label: local.projectContext,

      minLine: 1,

      maxLines: isDesktop ? 5 : 3,

      keyBoardType: TextInputType.multiline,

      hintText: local.projectContextDes,

      prefixIcon: const Icon(Icons.edit_note),

      radius: 18.r,
    );
  }
}
