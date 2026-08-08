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
import 'package:google_fonts/google_fonts.dart';

import '../cubit/profile_state.dart';

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
            CustomSnackBar.error(context, message: state.message);
          } else if (state is AccountDeleted) {
            CustomSnackBar.success(context, message: local.accountDeleted);
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = state is ProfileLoaded ? state.profile : null;

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final isTablet = width >= 600;
              final isDesktop = width >= 1024;

              final horizontalPadding = isDesktop
                  ? 40.0
                  : (isTablet ? 28.0 : 16.0);

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 700 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(context, local.personalInfo),
                        const HeightSpace(height: 12),
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
                            const CustomRowDivider(),

                            _buildListTile(
                              context: context,
                              title: local.email,
                              subtitle: profile?.email ?? local.loading,
                              trailing: const Icon(Icons.email),
                            ),
                          ],
                        ),
                        const HeightSpace(height: 24),
                        _buildSectionTitle(context, local.profile),
                        const HeightSpace(height: 12),
                        _buildSettingsCard(
                          context: context,
                          children: [
                            _buildListTile(
                              context: context,
                              title: local.profile,
                              subtitle: profile?.isGuest == true
                                  ? local.guestEplorer
                                  : local.aiDeveloper,
                              trailing: const Icon(Icons.person_outline),
                            ),
                            const CustomRowDivider(),
                            _buildListTile(
                              context: context,
                              title: local.emailVerification,
                              subtitle: local.emailStatus,
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: profile?.isGuest == true
                                      ? Colors.grey.withValues(alpha: 0.1)
                                      : const Color(
                                          0xff22C55E,
                                        ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  profile?.isGuest == true
                                      ? local.unverified
                                      : local.verified,
                                  style: GoogleFonts.inter(
                                    color: profile?.isGuest == true
                                        ? Colors.grey
                                        : const Color(0xff22C55E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const HeightSpace(height: 24),
                        _buildSectionTitle(
                          context,
                          local.dangerZone,
                          color: const Color(0xffFF5B5B),
                        ),
                        const HeightSpace(height: 12),
                        _buildSettingsCard(
                          context: context,
                          children: [
                            _buildListTile(
                              context: context,
                              title: local.deleteAcount,
                              subtitle: local.deleteAccountPermin,
                              titleColor: const Color(0xffFF5B5B),
                              onTap: () =>
                                  _showDeleteConfirmationDialog(context),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xffFF5B5B),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xffFF5B5B),
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const HeightSpace(height: 32),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEditIcon(BuildContext context) {
    return Icon(
      Icons.edit_outlined,
      color: Theme.of(context).colorScheme.secondary,
      size: 18,
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
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            S.of(context).editProfile,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          // ✅ تغليف الـ Form بـ SizedBox لتحديد العرض
          content: SizedBox(
            width: 400,
            child: Form(
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
                  borderRadius: BorderRadius.circular(8),
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
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                S.of(parentContext).cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                parentContext.read<ProfileCubit>().deleteAccount();
              },
              child: Text(
                S.of(parentContext).delete,
                style: const TextStyle(color: Color(0xffFF5B5B)),
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
        fontSize: 14,
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
        borderRadius: BorderRadius.circular(16),
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
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 12,
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
      size: 14,
    );
  }
}
