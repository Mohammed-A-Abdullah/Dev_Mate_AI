import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_row_divider.dart';
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
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: const CustomAppBar(title: 'Account Settings'),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              CustomSnackBar.show(context, message: state.message);
            } else if (state is AccountDeleted) {
              CustomSnackBar.show(
                context,
                message: 'Account deleted successfully.',
              );
              // Navigate to Login/Auth initial route
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
                  _buildSectionTitle(context, 'Personal Information'),
                  HeightSpace(height: 12.h),
                  _buildSettingsCard(
                    children: [
                      _buildListTile(
                        context: context,
                        title: 'Full Name',
                        subtitle: profile?.name ?? 'Loading...',
                      ),
                      CustomRowDivider(),
                      _buildListTile(
                        context: context,
                        title: 'Email',
                        subtitle: profile?.email ?? 'Loading...',
                      ),
                    ],
                  ),
                  HeightSpace(height: 24.h),
                  _buildSectionTitle(context, 'Security'),
                  HeightSpace(height: 12.h),
                  _buildSettingsCard(
                    children: [
                      _buildListTile(
                        context: context,
                        title: 'Change Password',
                        subtitle: 'Update your password',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),
                      CustomRowDivider(),
                      _buildListTile(
                        context: context,
                        title: 'Email Verification',
                        subtitle: 'Your email status',
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: profile!.isGuest
                                ? Colors.grey.withValues(alpha: 0.1)
                                : Color(0xff22C55E).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: profile!.isGuest
                              ? Text(
                                  'UnVerified',
                                  style: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  'Verified',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff22C55E),
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
                    'Danger Zone',
                    color: const Color(0xffFF5B5B),
                  ),
                  HeightSpace(height: 12.h),
                  _buildSettingsCard(
                    children: [
                      _buildListTile(
                        context: context,
                        title: 'Delete Account',
                        subtitle: 'Permanently delete your account',
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
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xff1A1D2D),
          title: Text(
            'Delete Account',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to permanently delete your account? This action cannot be undone.',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                parentContext.read<ProfileCubit>().deleteAccount();
              },
              child: const Text(
                'Delete',
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
      title, // Fixed parameter usage
      style: GoogleFonts.inter(
        color: color ?? Theme.of(context).colorScheme.secondary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1A1D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xff2A2D3D), width: 1),
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
