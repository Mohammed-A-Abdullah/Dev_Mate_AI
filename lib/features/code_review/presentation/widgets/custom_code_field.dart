import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCodeField extends StatelessWidget {
  const CustomCodeField({super.key, required this.codeController});
  final CodeController codeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      decoration: BoxDecoration(
        color: const Color(0xff1E1F26),
        borderRadius: BorderRadius.circular(16.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: CodeField(
        controller: codeController,
        decoration: const BoxDecoration(color: Colors.transparent),
        expands: true,
        gutterStyle: GutterStyle(
          background: Colors.transparent,
          showFoldingHandles: false,
          width: 45.w,
          margin: 10.w,
          textStyle: GoogleFonts.sourceCodePro(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14.sp,
          ),
        ),

        textStyle: GoogleFonts.sourceCodePro(
          fontSize: 14.sp,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
