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
                  color: Color(0xff1E1F26),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CodeField(
                  expands: true,
                  padding: EdgeInsets.all(5),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  controller: codeController,
                  textStyle: GoogleFonts.sourceCodePro(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              );
  }
}