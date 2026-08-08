import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomReviewInputDecorator extends StatelessWidget {
  const CustomReviewInputDecorator({
    super.key,
    this.onSelected,
    required this.reviewOptions,
    required this.selectedReviewOptions,
  });

  final void Function(bool)? onSelected;

  final List<String> reviewOptions;

  final List<String> selectedReviewOptions;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    final width = MediaQuery.sizeOf(context).width;

    final isTablet = width >= 600;
    final isDesktop = width >= 1024;

    final fontSize = isDesktop
        ? 15.0
        : isTablet
        ? 14.0
        : 13.0;

    return InputDecorator(
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,

        filled: true,

        labelText: local.language,

        hintText: local.programmingLang,

        hintStyle: GoogleFonts.inter(
          color: Theme.of(context).hintColor,
          fontSize: fontSize,
        ),

        labelStyle: TextStyle(color: Theme.of(context).hintColor),

        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      child: Wrap(
        spacing: isDesktop ? 10 : 8,
        runSpacing: isDesktop ? 10 : 8,

        children: reviewOptions.map((tech) {
          final selected = selectedReviewOptions.contains(tech);

          return FilterChip(
            label: Text(tech, style: GoogleFonts.inter(fontSize: fontSize)),

            selected: selected,

            onSelected: onSelected,
          );
        }).toList(),
      ),
    );
  }
}
