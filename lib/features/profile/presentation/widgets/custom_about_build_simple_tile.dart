import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAboutBuildSimpleTile extends StatelessWidget {
  const CustomAboutBuildSimpleTile({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}
