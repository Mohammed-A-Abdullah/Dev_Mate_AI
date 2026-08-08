import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_about_build_info_tile.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_about_build_simple_tile.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_row_divider.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> launchSafeUrl(BuildContext context, String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        if (context.mounted) {
          CustomSnackBar.error(
            context,
            message: S.of(context).couldNotOpenLink,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.error(context, message: S.of(context).AboutErrorAccurre);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: local.aboutDevMate),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final isTablet = width >= 600;
          final isDesktop = width >= 1024;

          final horizontalPadding = isDesktop ? 40.0 : (isTablet ? 28.0 : 16.0);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 700 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.logo, width: 100),
                    const HeightSpace(height: 16),
                    Text(
                      local.appName,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const HeightSpace(height: 4),
                    Text(
                      "Version 1.0.0",
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const HeightSpace(height: 4),
                    Text(
                      local.yourAIPowerdDeleCompanion,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const HeightSpace(height: 32),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).extension<ProfileThemeExtension>()!.profilCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          CustomAboutBuildInfoTile(
                            title: local.aboutDescription,
                            subtitle: local.aboutDescriptionText,
                            isLongText: true,
                          ),
                          const CustomRowDivider(),
                          CustomAboutBuildInfoTile(
                            title: local.aboutDeveloper,
                            subtitle: local.aboutDeveloperName,
                          ),
                          const CustomRowDivider(),
                          CustomAboutBuildInfoTile(
                            title: local.aboutBuildWith,
                            subtitle: local.aboutBuildWithData,
                          ),
                          const CustomRowDivider(),
                          InkWell(
                            onTap: () => launchSafeUrl(
                              context,
                              'https://mohammed-a-abdullah.github.io/portfolio_web/',
                            ),
                            child: CustomAboutBuildSimpleTile(
                              title: local.privaceyPolicy,
                            ),
                          ),
                          const CustomRowDivider(),
                          InkWell(
                            onTap: () => launchSafeUrl(
                              context,
                              'https://mohammed-a-abdullah.github.io/portfolio_web/',
                            ),
                            child: CustomAboutBuildSimpleTile(
                              title: local.termService,
                            ),
                          ),
                          const CustomRowDivider(),
                          InkWell(
                            onTap: () {
                              launchSafeUrl(
                                context,
                                'https://mohammed-a-abdullah.github.io/portfolio_web/',
                              );
                            },
                            child: CustomAboutBuildSimpleTile(
                              title: local.openSource,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const HeightSpace(height: 32),
                    Text(
                      local.copyWrite,
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const HeightSpace(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
