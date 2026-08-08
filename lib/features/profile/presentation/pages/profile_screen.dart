import 'dart:io';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_containter_user_type.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_image_section.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_setting_groupe.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_state_card.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/image_picker_dialog.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // ✅ Added Image Picker
import '../../../../core/theme/extensions/profile_status_theme_extension.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/language_dialoge.dart';
import 'account_settings_screen.dart';

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

  // ✅ Fixed Image Picker Logic
  Future<void> _showImagePicker(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();

    // 1. Wait for the dialog to return the user's choice
    final result = await showDialog<ImageSourceType>(
      context: context,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const ImagePickerDialog()),
    );

    if (result == null) return; // User canceled the dialog

    // 2. Handle the 'Delete' option
    if (result == ImageSourceType.delete) {
      await cubit.deletePhoto();
      return;
    }

    // 3. Handle Camera / Gallery using image_picker
    try {
      final picker = ImagePicker();
      final source = result == ImageSourceType.camera
          ? ImageSource.camera
          : ImageSource.gallery;

      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        await cubit.updatePhoto(File(pickedFile.path));
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.show(context, message: 'Failed to pick image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final statsTheme = Theme.of(
      context,
    ).extension<ProfileStatsThemeExtension>()!;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut || state is AccountDeleted) {
          context.goNamed(RouteName.authScreen);
        }

        if (state is ProfileError) {
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
          final roleLabel = profile.isGuest
              ? local.guestEplorer
              : local.aiDeveloper;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(title: local.profile, needButton: false),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final isTablet = width >= 600;
                  final isDesktop = width >= 1024;

                  final horizontalPadding = isDesktop
                      ? 40.0
                      : (isTablet ? 28.0 : 16.0);

                  // ✅ Added RefreshIndicator to update stats dynamically
                  return RefreshIndicator(
                    onRefresh: () => context.read<ProfileCubit>().loadProfile(),
                    child: SingleChildScrollView(
                      physics:
                          const AlwaysScrollableScrollPhysics(), // Ensures it can be pulled even if content is small
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isDesktop ? 700 : double.infinity,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeightSpace(height: 20),
                              Center(
                                child: Column(
                                  children: [
                                    CustomImageSection(
                                      onTap: () => _showImagePicker(context),
                                      photoUrl: photoUrl,
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      displayName,
                                      style: GoogleFonts.geist(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomContainterUserType(
                                      roleLabel: roleLabel,
                                    ),
                                  ],
                                ),
                              ),

                              const HeightSpace(height: 28),

                              Row(
                                children: [
                                  Expanded(
                                    child: CustomStateCard(
                                      value: profile.chats.toString(),
                                      label: local.chats,
                                      valueColor: statsTheme.chatsColor,
                                    ),
                                  ),
                                  const WidthSpace(width: 10),
                                  Expanded(
                                    child: CustomStateCard(
                                      value: profile.readmes.toString(),
                                      label: local.readme,
                                      valueColor: statsTheme.readmeColor,
                                    ),
                                  ),
                                  const WidthSpace(width: 10),
                                  Expanded(
                                    child: CustomStateCard(
                                      value: profile.analysis.toString(),
                                      label: local.review,
                                      valueColor: statsTheme.reviewColor,
                                    ),
                                  ),
                                ],
                              ),
                              const HeightSpace(height: 12),

                              Row(
                                children: [
                                  Expanded(
                                    child: CustomStateCard(
                                      value: profile.debug.toString(),
                                      label: local.debug,
                                      valueColor: statsTheme.debugColor,
                                    ),
                                  ),
                                  const WidthSpace(width: 10),
                                  Expanded(
                                    child: CustomStateCard(
                                      value: profile.explain.toString(),
                                      label: local.explain,
                                      valueColor: statsTheme.explainColor,
                                    ),
                                  ),
                                  const WidthSpace(width: 10),
                                  Expanded(
                                    child: CustomStateCard(
                                      value: profile.planner.toString(),
                                      label: local.planner,
                                      valueColor: statsTheme.analysisColor,
                                    ),
                                  ),
                                ],
                              ),
                              const HeightSpace(height: 24),

                              CustomSettingGroupe(
                                onAccountSettingsTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<ProfileCubit>(),
                                        child: const AccountSettingsScreen(),
                                      ),
                                    ),
                                  );
                                },
                                onLanguageTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => const LanguageDialog(),
                                  );
                                },
                                onAboutTap: () {
                                  context.pushNamed(RouteName.aboutScreen);
                                },
                                onLogoutTap: () {
                                  _showLogoutConfirmationDialog(context);
                                },
                                // ... other code ...
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 12),
                Text(
                  state is ProfileError ? state.message : '',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => context.read<ProfileCubit>().loadProfile(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).logout),
        content: Text(S.of(context).logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(S.of(context).logout),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      await context.read<ProfileCubit>().logout();
    }
  }
}
