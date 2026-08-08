import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.needButton = true,
  });

  final String title;
  final bool needButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,

      centerTitle: true,

      backgroundColor:
          theme.appBarTheme.backgroundColor,

      elevation: 0,

      scrolledUnderElevation: 0,

      surfaceTintColor: Colors.transparent,

      titleSpacing: 0,

      title: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth =
              MediaQuery.sizeOf(context).width;

          // Mobile
          if (screenWidth < 600) {
            return _buildTitle(
              context,
              fontSize: 22,
            );
          }

          // Tablet
          if (screenWidth < 1024) {
            return _buildTitle(
              context,
              fontSize: 24,
            );
          }

          // Desktop
          return _buildTitle(
            context,
            fontSize: 26,
          );
        },
      ),

      leading: needButton
          ? Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: IconButton(
                tooltip: 'Back',

                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),

                iconSize: 21,

                padding:
                    const EdgeInsets.all(10),

                constraints:
                    const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),

                onPressed: () {
                  Navigator.maybePop(
                    context,
                  );
                },
              ),
            )
          : null,
    );
  }

  Widget _buildTitle(
    BuildContext context, {
    required double fontSize,
  }) {
    final theme = Theme.of(context);

    return Text(
      title,

      maxLines: 1,

      overflow: TextOverflow.ellipsis,

      textAlign: TextAlign.center,

      style: GoogleFonts.geist(
        fontSize: fontSize,

        fontWeight:
            FontWeight.bold,

        color:
            theme.colorScheme.primary,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(
        kToolbarHeight,
      );
}
