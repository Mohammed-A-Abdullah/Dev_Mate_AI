import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/extensions/profile_theme_extension.dart';

class CustomContainterUserType extends StatelessWidget {
  const CustomContainterUserType({super.key, required this.roleLabel});
  final String roleLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).extension<ProfileThemeExtension>()!.profilCard,
                              borderRadius: BorderRadius.circular(999.r),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: Text(
                              roleLabel,
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                              ),
                            ),
                          );
  }
}