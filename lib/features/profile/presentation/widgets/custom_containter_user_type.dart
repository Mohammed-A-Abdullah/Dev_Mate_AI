import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/extensions/profile_theme_extension.dart';

class CustomContainterUserType extends StatelessWidget {
  const CustomContainterUserType({super.key, required this.roleLabel});
  final String roleLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<ProfileThemeExtension>()!.profilCard,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Text(
        roleLabel,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
