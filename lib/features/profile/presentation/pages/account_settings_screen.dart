import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_row_divider.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/profile_state.dart';
import 'change_password_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: local.accountSetting),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            CustomSnackBar.show(context, message: state.message);
          } else if (state is AccountDeleted) {
            CustomSnackBar.show(context, message: local.accountDeleted);
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = state is ProfileLoaded ? state.profile : null;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, local.personalInfo),
                HeightSpace(height: 12.h),
                _buildSettingsCard(
                  context: context,
                  children: [
                    _buildListTile(
                      context: context,
                      title: local.fullName,
                      subtitle: profile?.name ?? local.loading,
                      trailing: _buildEditIcon(context),
                      onTap: () {
                        if (profile != null) {
                          _showEditProfileDialog(
                            context: context,
                            cubit: context.read<ProfileCubit>(),
                            currentName: profile.name,
                          );
                        }
                      },
                    ),
                    CustomRowDivider(),

                    _buildListTile(
                      context: context,
                      title: local.email,
                      subtitle: profile?.email ?? local.loading,
                      trailing: Icon(Icons.email),
                    ),
                  ],
                ),
                HeightSpace(height: 24.h),
                _buildSectionTitle(context, local.security),
                HeightSpace(height: 12.h),
                _buildSettingsCard(
                  context: context,
                  children: [
                    _buildListTile(
                      context: context,
                      title: local.changePass,
                      subtitle: local.updatePassword,
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ChangePasswordDialog(
                            cubit: context.read<ProfileCubit>(),
                          ),
                        );
                      },
                    ),
                    CustomRowDivider(),
                    _buildListTile(
                      context: context,
                      title: local.emailVerification,
                      subtitle: local.emailStatus,
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: profile?.isGuest == true
                              ? Colors.grey.withValues(alpha: 0.1)
                              : const Color(0xff22C55E).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          profile?.isGuest == true
                              ? local.unverified
                              : local.verified,
                          style: GoogleFonts.inter(
                            color: profile?.isGuest == true
                                ? Colors.grey
                                : const Color(0xff22C55E),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                HeightSpace(height: 24.h),
                _buildSectionTitle(
                  context,
                  local.dangerZone,
                  color: const Color(0xffFF5B5B),
                ),
                HeightSpace(height: 12.h),
                _buildSettingsCard(
                  context: context,
                  children: [
                    _buildListTile(
                      context: context,
                      title: local.deleteAcount,
                      subtitle: local.deleteAccountPermin,
                      titleColor: const Color(0xffFF5B5B),
                      onTap: () => _showDeleteConfirmationDialog(context),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: const Color(0xffFF5B5B),
                            size: 22.sp,
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: const Color(0xffFF5B5B),
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                HeightSpace(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditIcon(BuildContext context) {
    return Icon(
      Icons.edit_outlined,
      color: Theme.of(context).colorScheme.secondary,
      size: 18.sp,
    );
  }

  void _showEditProfileDialog({
    required BuildContext context,
    required ProfileCubit cubit,
    required String currentName,
  }) {
    final nameController = TextEditingController(text: currentName);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            S.of(context).editProfile,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: nameController,
                  hintText: S.of(context).fullName,
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                  keyBoardType: TextInputType.text,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                S.of(context).cancel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.updateProfileDetails(nameController.text.trim());
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(
                S.of(context).save,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            S.of(parentContext).deleteAccount,
            style: GoogleFonts.inter(
              color: Theme.of(parentContext).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            S.of(parentContext).deleteAccountDesc,
            style: GoogleFonts.inter(
              color: Theme.of(parentContext).colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                S.of(parentContext).cancel,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                parentContext.read<ProfileCubit>().deleteAccount();
              },
              child: Text(
                S.of(parentContext).delete,
                style: TextStyle(color: Color(0xffFF5B5B)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title, {
    Color? color,
  }) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: color ?? Theme.of(context).colorScheme.secondary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSettingsCard({
    required BuildContext context,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<ProfileThemeExtension>()!.profilCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color:
                          titleColor ?? Theme.of(context).colorScheme.secondary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing ?? _buildChevron(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChevron(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: Theme.of(context).colorScheme.secondary,
      size: 14.sp,
    );
  }
}
