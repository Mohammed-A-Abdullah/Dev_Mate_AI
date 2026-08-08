import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAboutBuildInfoTile extends StatelessWidget {
  const CustomAboutBuildInfoTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.trailingIcon,
    this.isLongText = false,
  });
  final String title;
  final String subtitle;
  final bool isLongText;
  final Color? subtitleColor;
  final IconData? trailingIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: isLongText
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: subtitleColor ?? const Color(0xff8E92A8),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 8),
            Icon(trailingIcon, color: const Color(0xff8E92A8), size: 16),
          ] else ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff8E92A8),
              size: 14,
            ),
          ],
        ],
      ),
    );
  }
}
