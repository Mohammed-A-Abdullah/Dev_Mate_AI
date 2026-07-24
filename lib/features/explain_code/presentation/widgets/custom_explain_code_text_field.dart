import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomExplainCodeTextField extends StatelessWidget {
  const CustomExplainCodeTextField({super.key, required this.instructionsController});
  final TextEditingController instructionsController;
  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
    return CustomTextField(
                controller: instructionsController,
                label: local.additionalInstruction,
                minLine: 1,
                maxLines: 3,
                keyBoardType: TextInputType.multiline,
                hintText: local.additionalinstructionDes,
                prefixIcon: const Icon(
                  Icons.edit_note,
                ),
                hintTextStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                ),
              );
  }
}