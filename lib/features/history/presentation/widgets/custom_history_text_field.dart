import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomHistoryTextField extends StatelessWidget {
  const CustomHistoryTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
                borderColor: Color(0xff434654),
                fillColor: Color(0xff1E1F26),
                hintText: 'Search history...',
                hintTextStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Color(0xff434654),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xffC3C5D7),
                  size: 20.sp,
                ),
                radius: 50.r,
              );
  }
}