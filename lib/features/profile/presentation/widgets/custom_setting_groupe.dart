import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:dev_mate_ai/core/theme/theme_cubit.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_row_divider.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_setting_row.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:dev_mate_ai/l10n/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSettingGroupe extends StatelessWidget {
  const CustomSettingGroupe({
    super.key,
    required this.onAccountSettingsTap,
    required this.onLanguageTap,
    required this.onAboutTap,
    required this.onLogoutTap,
  });

  final VoidCallback onAccountSettingsTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = S.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.extension<ProfileThemeExtension>()!.profilCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        children: [
          CustomSettingRow(
            icon: Icons.manage_accounts_outlined,
            title: local.accountSetting,
            onTap: onAccountSettingsTap,
          ),
          const CustomRowDivider(),

          // --- Theme Switcher Linked to Cubit ---
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDarkMode = themeMode == ThemeMode.dark;
              return CustomSettingRow(
                icon: Icons.dark_mode_outlined,
                title: local.theme,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isDarkMode ? local.dark : local.light,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const WidthSpace(width: 4),
                    SizedBox(
                      height: 24,
                      child: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: isDarkMode,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeThumbColor: theme.colorScheme.primary,
                          inactiveThumbColor: theme.colorScheme.primary,
                          inactiveTrackColor: theme.colorScheme.onPrimary,
                          focusColor: theme.colorScheme.onPrimary,

                          onChanged: (value) {
                            context.read<ThemeCubit>().toggleTheme(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const CustomRowDivider(),
          BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              final currentLanguage = locale.languageCode == 'ar'
                  ? 'العربية'
                  : 'English';

              return Column(
                children: [
                  CustomSettingRow(
                    icon: Icons.translate_rounded,
                    title: local.language,
                    trailing: Text(
                      currentLanguage,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: onLanguageTap,
                  ),
                  const CustomRowDivider(),
                ],
              );
            },
          ),
          CustomSettingRow(
            icon: Icons.info_outline,
            title: local.aboutDevMate,
            onTap: onAboutTap,
          ),
          const CustomRowDivider(),
          CustomSettingRow(
            icon: Icons.logout,
            title: local.logout,
            titleColor: const Color(0xffFF8A8A),
            iconColor: const Color(0xffFF8A8A),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Color(0xffFF8A8A),
            ),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}
