import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/route_name.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () => context.goNamed(RouteName.authScreen),
        child: Text(
          "SKIP",
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11.sp,
            color: const Color(0xffC3C5D7),
          ),
        ),
      ),
    );
  }
}
