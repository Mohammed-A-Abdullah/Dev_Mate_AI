import 'package:dev_mate_ai/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingEntity pageData;

  final double iconSize;
  final double titleFontSize;
  final double descriptionFontSize;

  final bool isDesktop;

  const OnboardingPageContent({
    super.key,
    required this.pageData,
    required this.iconSize,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return _buildDesktop(context);
    }

    return _buildMobileTablet(context);
  }

  Widget _buildMobileTablet(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              pageData.icon,
              size: iconSize,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: 50),

            Text(
              pageData.title,

              textAlign: TextAlign.center,

              style: GoogleFonts.geist(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.secondary,
              ),
            ),

            const SizedBox(height: 16),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),

              child: Text(
                pageData.description,

                textAlign: TextAlign.center,

                style: GoogleFonts.inter(
                  fontSize: descriptionFontSize,

                  height: 1.6,

                  fontWeight: FontWeight.w400,

                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: iconSize + 80,
                height: iconSize + 80,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: theme.colorScheme.primary.withValues(alpha: .08),

                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: .15),
                  ),
                ),

                child: Icon(
                  pageData.icon,

                  size: iconSize,

                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),

          const SizedBox(width: 70),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    pageData.title,

                    style: GoogleFonts.geist(
                      fontSize: titleFontSize,

                      fontWeight: FontWeight.w700,

                      color: theme.colorScheme.secondary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),

                    child: Text(
                      pageData.description,

                      style: GoogleFonts.inter(
                        fontSize: descriptionFontSize,

                        height: 1.7,

                        fontWeight: FontWeight.w400,

                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
