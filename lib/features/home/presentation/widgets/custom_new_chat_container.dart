import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNewChatContainer extends StatelessWidget {
  const CustomNewChatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomeThemeExtension>()!;
    final local = S.of(context);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: homeTheme.homeCard,

        borderRadius: BorderRadius.circular(28),

        border: Border.all(color: theme.colorScheme.outline, width: 1),

        gradient: RadialGradient(
          center: const Alignment(0.7, 0.9),

          radius: 1.2,

          colors: [
            homeTheme.homeCardGradient,
            homeTheme.secondHomeCardGradient,
          ],

          stops: const [0.0, 0.7],
        ),
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 350;

          final titleSize = isSmall ? 18.0 : 20.0;

          final buttonWidth = isSmall ? 110.0 : 120.0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                local.homeWhatCanIHelp,

                style: GoogleFonts.inter(
                  fontSize: titleSize,

                  fontWeight: FontWeight.w500,

                  color: theme.colorScheme.secondary,
                ),
              ),

              const SizedBox(height: 16),

              Material(
                color: Colors.transparent,

                child: InkWell(
                  borderRadius: BorderRadius.circular(50),

                  onTap: () {
                    context.read<NavigationCubit>().changeIndex(1);
                  },

                  child: Ink(
                    width: buttonWidth,

                    height: 38,

                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,

                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.add_circle_outline,

                          size: 17,

                          color: theme.colorScheme.onPrimary,
                        ),

                        const SizedBox(width: 5),

                        Flexible(
                          child: Text(
                            local.newChat,

                            overflow: TextOverflow.ellipsis,

                            style: GoogleFonts.inter(
                              color: theme.colorScheme.onPrimary,

                              fontSize: 14,

                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
