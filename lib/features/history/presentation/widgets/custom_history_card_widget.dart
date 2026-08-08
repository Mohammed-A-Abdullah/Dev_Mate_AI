import 'package:dev_mate_ai/core/theme/extensions/history_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/extensions/home_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/widgets/spacing_widgets.dart';

class CustomHistoryCardWidget extends StatelessWidget {
  const CustomHistoryCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.chipType,
    required this.time,
    this.onTap,
  });
  final String title;
  final String description;
  final String chipType;
  final DateTime time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).extension<HistoryThemeExtension>()!.historyCard,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const HeightSpace(height: 8),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const HeightSpace(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      chipType,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).extension<HistoryThemeExtension>()!.chipLableText,
                      ),
                    ),
                    backgroundColor: Theme.of(
                      context,
                    ).extension<HomeThemeExtension>()!.iconCardQuickTool,
                    side: const BorderSide(color: Colors.transparent),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                  ),
                  Text(
                    timeago.format(time),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).extension<HistoryThemeExtension>()!.timeago,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
