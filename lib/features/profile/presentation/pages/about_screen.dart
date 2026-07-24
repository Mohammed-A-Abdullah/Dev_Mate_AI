import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_about_build_info_tile.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_about_build_simple_tile.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_row_divider.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(S.of(context).couldNotOpenLink),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(S.of(context).AboutErrorAccurre),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local =S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: local.aboutDevMate),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logo, width: 100.w),
            HeightSpace(height: 16),
            Text(
              local.appName,
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            HeightSpace(height: 4),
            Text(
              "Version 1.0.0",
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 14.sp,
              ),
            ),
            HeightSpace(height: 4),
            Text(
              local.yourAIPowerdDeleCompanion,
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 14.sp,
              ),
            ),
            HeightSpace(height: 32),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).extension<ProfileThemeExtension>()!.profilCard,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  CustomAboutBuildInfoTile(
                    title: local.aboutDescription,
                    subtitle:
                        local.aboutDescriptionText,
                    isLongText: true,
                  ),
                  CustomRowDivider(),
                  CustomAboutBuildInfoTile(
                    title: local.aboutDeveloper,
                    subtitle: local.aboutDeveloperName,
                  ),
                  CustomRowDivider(),
                  CustomAboutBuildInfoTile(
                    title: local.aboutBuildWith,
                    subtitle: local.aboutBuildWithData,
                  ),
                  CustomRowDivider(),
                  InkWell(
                    onTap: () => launchSafeUrl(
                      context,
                      'https://mohammed-a-abdullah.github.io/portfolio_web/',
                    ),
                    child: CustomAboutBuildSimpleTile(title: local.privaceyPolicy),
                  ),
                  CustomRowDivider(),
                  InkWell(
                    onTap: () => launchSafeUrl(
                      context,
                      'https://mohammed-a-abdullah.github.io/portfolio_web/',
                    ),
                    child: CustomAboutBuildSimpleTile(title: local.termService),
                  ),
                  CustomRowDivider(),
                  InkWell(
                    onTap: () {
                      launchSafeUrl(
                        context,
                        'https://mohammed-a-abdullah.github.io/portfolio_web/',
                      );
                    },
                    child: CustomAboutBuildSimpleTile(title: local.openSource),
                  ),
                ],
              ),
            ),
            HeightSpace(height: 32.h),
            Text(
              local.copyWrite,
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 12.sp,
              ),
            ),
            HeightSpace(height: 16.h),
          ],
        ),
      ),
    );
  }
}
