import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';
import 'package:dev_mate_ai/features/home/presentation/helper/home_tool_helper.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickToolItem extends StatelessWidget {
  const QuickToolItem({super.key, required this.tool});

  final HomeQuickToolEntity tool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomeThemeExtension>()!;
    final local = S.of(context);

    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {
          GoRouter.of(context).pushNamed(HomeToolHelper.route(tool.type));
        },

        child: Ink(
          width: double.infinity,
          height: double.infinity,

          decoration: BoxDecoration(
            color: homeTheme.homeCard,

            borderRadius: BorderRadius.circular(16),

            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: .5),
            ),
          ),

          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final isSmall = width < 130;

              final iconSize = isSmall ? 36.0 : 42.0;

              final iconInnerSize = isSmall ? 18.0 : 20.0;

              final titleSize = isSmall ? 12.0 : 14.0;

              final descriptionSize = isSmall ? 9.5 : 11.0;

              final padding = isSmall ? 12.0 : 16.0;

              return Padding(
                padding: EdgeInsets.all(padding),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: iconSize,
                      height: iconSize,

                      decoration: BoxDecoration(
                        color: homeTheme.iconCardQuickTool,

                        borderRadius: BorderRadius.circular(9),
                      ),

                      child: Icon(
                        HomeToolHelper.icon(tool.type),

                        size: iconInnerSize,

                        color: HomeToolHelper.color(tool.type),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      HomeToolHelper.title(tool.type, local),

                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,

                      style: GoogleFonts.inter(
                        fontSize: titleSize,

                        fontWeight: FontWeight.w600,

                        color: theme.colorScheme.secondary,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Expanded(
                      child: Text(
                        HomeToolHelper.description(tool.type, local),

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                        style: GoogleFonts.jetBrainsMono(
                          fontSize: descriptionSize,

                          height: 1.3,

                          fontWeight: FontWeight.w400,

                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
