import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomProjectPlannerTextField extends StatelessWidget {
  const CustomProjectPlannerTextField({super.key, required this.controller, required this.title, required this.description});
final TextEditingController controller;
final String title;
final String description;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
                controller: controller,
                label: title,
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText: description,
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