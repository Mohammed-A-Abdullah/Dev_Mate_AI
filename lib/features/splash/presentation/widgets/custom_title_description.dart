import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/spacing_widgets.dart';

class CustomTitleDescription extends StatelessWidget {
  const CustomTitleDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'DevMate AI',
          style: GoogleFonts.geist(
            fontSize: 40.sp,
            color: Color(0xffE2E2EB),
            fontWeight: FontWeight.bold,
          ),
        ),
        HeightSpace(height: 8),
        SizedBox(
          width: 211.w,
          child: Text(
            'Your AI-Powered Developer Assistant',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Color(0xffC3C5D7),
              fontSize: 16.sp,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
      ],
    );
  }
}
