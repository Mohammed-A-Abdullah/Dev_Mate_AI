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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> _handleImageAction(BuildContext context) async {
    // 1. فتح الـ Dialog لمعرفة اختيار المستخدم
    final action = await showDialog<ImageSourceType>(
      context: context,
      builder: (_) {
        return const ImagePickerDialog();
      },
    );

    if (action == null) return;

    if (!context.mounted) return;

    final cubit = context.read<ProfileCubit>();

    if (action == ImageSourceType.delete) {
      cubit.deletePhoto();
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: action == ImageSourceType.camera
          ? ImageSource.camera
          : ImageSource.gallery,
    );

    if (pickedFile != null) {
      cubit.updatePhoto(File(pickedFile.path));
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(height: 20),
                    Center(
                      child: Column(
                        children: [
                          CustomImageSection(
                            onTap: () => _handleImageAction(context),
                            photoUrl: profile.imageUrl,
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            displayName,
                            style: GoogleFonts.geist(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomContainterUserType(roleLabel: roleLabel),
                        ],
                      ),
                    ),

                    HeightSpace(height: 28.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomStateCard(
                            value: profile.chats.toString(),
                            label: local.chats,
                            valueColor: statsTheme.chatsColor,
                          ),
                        ),
                        WidthSpace(width: 10.w),
                        Expanded(
                          child: CustomStateCard(
                            value: profile.readmes.toString(),
                            label: local.readme,
                            valueColor: statsTheme.readmeColor,
                          ),
                        ),
                        WidthSpace(width: 10.w),
                        Expanded(
                          child: CustomStateCard(
                            value: profile.analysis.toString(),
                            label: local.review,
                            valueColor: statsTheme.reviewColor,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: CustomStateCard(
                            value: profile.debug
                                .toString(),
                            label: local.debug,
                            valueColor: statsTheme.debugColor,
                          ),
                        ),
                        WidthSpace(width: 10.w),
                        Expanded(
                          child: CustomStateCard(
                            value: profile.explain
                                .toString(), 
                            label: local.explain,
                            valueColor: statsTheme.explainColor,
                          ),
                        ),
                        WidthSpace(width: 10.w),
                        Expanded(
                          child: CustomStateCard(
                            value: profile.planner
                                .toString(),
                            label: local.planner,
                            valueColor: statsTheme.analysisColor,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(height: 24.h),

                    CustomSettingGroupe(
                      onAccountSettingsTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context_) => BlocProvider.value(
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
                      onAboutTap: () async {
                        context.pushNamed(RouteName.aboutScreen);
                      },
                      onLogoutTap: () {
                        context.read<ProfileCubit>().logout();
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
