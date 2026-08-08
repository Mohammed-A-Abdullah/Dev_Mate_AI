import 'package:dev_mate_ai/core/theme/extensions/dropdown_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });
  final String text;
  final void Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(
                  context,
                ).extension<DropdownThemeExtension>()!.dropdownColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: isSelected
                ? Theme.of(
                    context,
                  ).extension<DropdownThemeExtension>()!.dropdownColor
                : Theme.of(context).colorScheme.primary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
