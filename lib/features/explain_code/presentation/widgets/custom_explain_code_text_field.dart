import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomExplainCodeTextField extends StatelessWidget {
  const CustomExplainCodeTextField({super.key, required this.instructionsController});
  final TextEditingController instructionsController;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
                controller: instructionsController,
                label: 'Additional Instructions (Optional)',
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                minLine: 1,
                maxLines: 3,
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText: 'e.g. Explain line by line, focus on performance...',
                prefixIcon: const Icon(
                  Icons.edit_note,
                  color: Color(0xffC3C5D7),
                ),
                fillColor: const Color(0xff1E1F26),
                borderColor: const Color(0xff434654),
                radius: 18.r,
                textStyle: GoogleFonts.inter(color: Colors.white),
                hintTextStyle: GoogleFonts.inter(
                  color: const Color(0xff6F7385),
                  fontSize: 14.sp,
                ),
              );
  }
}