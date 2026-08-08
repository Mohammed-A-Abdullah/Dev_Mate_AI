import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTitleDescription extends StatelessWidget {
  final double titleSize;
  final double descriptionSize;

  const CustomTitleDescription({
    super.key,
    required this.titleSize,
    required this.descriptionSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).appName,
          style: GoogleFonts.geist(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            S.of(context).Your_AI_Powered_Developer_Assistant,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: descriptionSize),
          ),
        ),
      ],
    );
  }
}
