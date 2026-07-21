import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:dev_mate_ai/features/history/data/datasource/history_remote_data_source_impl.dart';
import 'package:dev_mate_ai/features/history/data/repositories/history_repository_impl.dart';
import 'package:dev_mate_ai/features/history/domain/usecases/get_history_use_case.dart';
import 'package:dev_mate_ai/features/history/presentation/cubit/history_cubit.dart';
import 'package:dev_mate_ai/features/history/presentation/cubit/history_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (_) => sl<ProfileCubit>()..loadProfile(),
  child: const ProfileView(),
);
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> _launchExternalUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          CustomSnackBar.show(
            context,
            message: 'Unable to open the link right now.',
          );
        }
      }
    } catch (_) {
      if (context.mounted) {
        CustomSnackBar.show(
          context,
          message: 'Unable to open the link right now.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          context.goNamed(RouteName.authScreen);
        }

        if (state is ProfileError) {
          print('================================================');
          print(state.message);
          CustomSnackBar.show(context, message: state.message);
        }
      },
      builder: (context, state) {
        
          if (state is ProfileLoading || state is ProfileInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ProfileLoaded) {
        final profile = state.profile;
          final displayName = profile.name;
          final photoUrl = profile.imageUrl;
          final roleLabel = profile.isGuest ? "Guest Explorer" : "AI Developer";
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CustomAppBar(title: "Profile", needButton: false),
          body: SafeArea(
            child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Center(
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 96.w,
                                    height: 96.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context)
                                              .extension<
                                                ProfileThemeExtension
                                              >()!
                                              .profilCardGradient,
                                          Theme.of(context)
                                              .extension<
                                                ProfileThemeExtension
                                              >()!
                                              .secondprofilCardGradient,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      border: Border.all(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: photoUrl != null
                                          ? Image.network(
                                              photoUrl,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  Icon(
                                                    Icons.person,
                                                    size: 44.sp,
                                                    color: Colors.white,
                                                  ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 44.sp,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -2,
                                    right: -2,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(
                                        999.r,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(7.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .extension<
                                                ProfileThemeExtension
                                              >()!
                                              .profilCard,
                                          border: Border.all(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.outline,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(Icons.edit, size: 14.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                displayName,
                                style: GoogleFonts.geist(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .extension<ProfileThemeExtension>()!
                                      .profilCard,
                                  borderRadius: BorderRadius.circular(999.r),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ),
                                child: Text(
                                  roleLabel,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 28.h),

                        Row(
  children: [
    Expanded(
      child: _StatCard(
        value: profile.chats.toString(),
        label: "Chats",
        valueColor: const Color(0xffB5C4FF),
      ),
    ),
    SizedBox(width: 10.w),
    Expanded(
      child: _StatCard(
        value: profile.readmes.toString(),
        label: "READMEs",
        valueColor: const Color(0xffC79DFF),
      ),
    ),
    SizedBox(width: 10.w),
    Expanded(
      child: _StatCard(
        value: profile.analysis.toString(),
        label: "Analysis",
        valueColor: const Color(0xff6EE7B7),
      ),
    ),
  ],
),

                        SizedBox(height: 24.h),

                        _SettingsGroup(
                          onAccountSettingsTap: () {
                            context.pushNamed(RouteName.settingsScreen);
                          },
                          onNotificationsTap: () {
                            context.pushNamed(RouteName.notificationsScreen);
                          },
                          onAppPreferencesTap: () {
                            // TODO: add an appPreferencesScreen route name
                            // and push it here.
                          },
                          onAboutTap: () async {
                            await _launchExternalUrl(
                              context,
                              'https://firebase.google.com/support/privacy',
                            );
                          },
                          onLogoutTap: () async {
                            context.read<ProfileCubit>().logout();
                            if (context.mounted) {
                              context.goNamed(RouteName.authScreen);
                            }
                          },
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
          ),
        );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xff1C1E28),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.geist(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xffC3C5D7),
            ),
          ),
        ],
      ),
    );
  }
}

/// Grouped, card-style settings list matching the reference design:
/// rows separated by dividers inside a single rounded container, with
/// a switch row for theme and a red logout row at the bottom.
class _SettingsGroup extends StatefulWidget {
  const _SettingsGroup({
    required this.onAccountSettingsTap,
    required this.onNotificationsTap,
    required this.onAppPreferencesTap,
    required this.onAboutTap,
    required this.onLogoutTap,
  });

  final VoidCallback onAccountSettingsTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onAppPreferencesTap;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  @override
  State<_SettingsGroup> createState() => _SettingsGroupState();
}

class _SettingsGroupState extends State<_SettingsGroup> {
  // Local placeholder state — wire this to a real ThemeCubit /
  // ThemeMode.system persistence layer when you build one.
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1C1E28),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Column(
        children: [
          _SettingRow(
            icon: Icons.manage_accounts_outlined,
            title: 'Account Settings',
            onTap: widget.onAccountSettingsTap,
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.dark_mode_outlined,
            title: 'Theme',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isDarkMode ? 'Dark' : 'Light',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xffC3C5D7),
                  ),
                ),
                SizedBox(width: 8.w),
                Switch(
                  value: _isDarkMode,
                  activeColor: const Color(0xffB5C4FF),
                  onChanged: (value) {
                    setState(() => _isDarkMode = value);
                    // TODO: call context.read<ThemeCubit>().toggle()
                    // once a ThemeCubit exists in the app.
                  },
                ),
              ],
            ),
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: widget.onNotificationsTap,
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.tune,
            title: 'App Preferences',
            onTap: widget.onAppPreferencesTap,
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.info_outline,
            title: 'About DevMate AI',
            onTap: widget.onAboutTap,
          ),
          const _RowDivider(),
          _SettingRow(
            icon: Icons.logout,
            title: 'Logout',
            titleColor: const Color(0xffFF8A8A),
            iconColor: const Color(0xffFF8A8A),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: const Color(0xffFF8A8A),
            ),
            onTap: widget.onLogoutTap,
          ),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: const Color(0xff2A2D3A),
      indent: 14.w,
      endIndent: 14.w,
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.titleColor,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? titleColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: iconColor ?? const Color(0xffB5C4FF),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? const Color(0xffE2E2EB),
                ),
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15.sp,
                  color: const Color(0xffC3C5D7),
                ),
          ],
        ),
      ),
    );
  }
}
