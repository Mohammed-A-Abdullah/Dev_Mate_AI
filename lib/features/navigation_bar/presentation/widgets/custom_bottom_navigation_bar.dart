import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_selected_icon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    this.onTap,
    required this.currentIndex,
  });

  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = S.of(context);

    return SafeArea(
      top: false,

      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,

          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: .5),

              width: 1,
            ),
          ),
        ),

        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: onTap,

          elevation: 0,

          backgroundColor: Colors.transparent,

          type: BottomNavigationBarType.fixed,

          selectedItemColor: theme.colorScheme.primary,

          unselectedItemColor: theme.colorScheme.onSecondary,

          selectedLabelStyle: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),

          unselectedLabelStyle: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),

          items: [
            BottomNavigationBarItem(
              icon: currentIndex == 0
                  ? const CustomSelectedIcon(iconData: Icons.home)
                  : const Icon(Icons.home_outlined),

              label: local.home,
            ),

            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? const CustomSelectedIcon(iconData: Icons.chat_bubble)
                  : const Icon(Icons.chat_bubble_outline),

              label: local.chats,
            ),

            BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? const CustomSelectedIcon(iconData: Icons.history)
                  : const Icon(Icons.history),

              label: local.history,
            ),

            BottomNavigationBarItem(
              icon: currentIndex == 3
                  ? const CustomSelectedIcon(iconData: Icons.person)
                  : const Icon(Icons.person_outline),

              label: local.profile,
            ),
          ],
        ),
      ),
    );
  }
}
