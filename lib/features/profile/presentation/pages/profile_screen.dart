import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:dev_mate_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_github_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_guest_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_google_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_up_usecase.dart';
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(remote: FirebaseAuthDataSource());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            checkAuthStatusUseCase: CheckAuthStatusUseCase(authRepository),
            signInUseCase: SignInUseCase(authRepository),
            signUpUseCase: SignUpUseCase(authRepository),
            signOutUseCase: SignOutUseCase(authRepository),
            googleUseCase: SignInGoogleUseCase(authRepository),
            githubUseCase: SignInGithubUseCase(authRepository),
            guestUseCase: SignInGuestUseCase(authRepository),
            sendEmailVerificationUseCase: SendEmailVerificationUseCase(
              authRepository,
            ),
          )..checkAuthStatus(),
        ),
        BlocProvider(
          create: (context) => HistoryCubit(
            GetHistoryUseCase(
              HistoryRepositoryImpl(
                HistoryRemoteDataSourceImpl(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance,
                ),
              ),
            ),
          )..loadHistory(),
        ),
      ],
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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final currentUser = FirebaseAuth.instance.currentUser;
        final isAuthenticated =
            state is AuthAuthenticated || currentUser != null;
        final displayName = currentUser?.displayName?.trim().isNotEmpty == true
            ? currentUser!.displayName!
            : (isAuthenticated ? 'DevMate User' : 'Guest User');
        final email = currentUser?.email?.trim().isNotEmpty == true
            ? currentUser!.email!
            : (isAuthenticated ? 'No email linked yet' : 'welcome@devmate.ai');
        final isGuest =
            currentUser?.isAnonymous == true ||
            (currentUser?.email?.contains('guest') ?? false);

        return Scaffold(
          backgroundColor: const Color(0xff111319),
          appBar: AppBar(
            backgroundColor: const Color(0xff111319),
            elevation: 0,
            title: Text(
              'Profile',
              style: GoogleFonts.geist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xffE2E2EB),
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xffB5C4FF)),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: const Color(0xff1C1E28),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: const Color(0xff2A2D3A),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 72.w,
                                height: 72.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffB5C4FF),
                                      Color(0xff7C8DFF),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 36.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                displayName,
                                style: GoogleFonts.geist(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xffE2E2EB),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                email,
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: const Color(0xffC3C5D7),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: _ProfileChip(
                                      icon: Icons.auto_awesome,
                                      label: isGuest
                                          ? 'Guest Mode'
                                          : 'AI Dev Mode',
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: _ProfileChip(
                                      icon: Icons.workspace_premium,
                                      label: isGuest ? 'Free Plan' : 'Pro Plan',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Your workspace',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffE2E2EB),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        BlocBuilder<HistoryCubit, HistoryState>(
                          builder: (context, historyState) {
                            final int count = historyState is HistoryLoaded
                                ? historyState.history.length
                                : 0;
                            final int projectCount = count > 0
                                ? (count ~/ 2) + 1
                                : 0;

                            return Row(
                              children: [
                                Expanded(
                                  child: _StatCard(
                                    title: 'Projects',
                                    value: projectCount.toString(),
                                    icon: Icons.folder_open,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: _StatCard(
                                    title: 'Chats',
                                    value: count.toString(),
                                    icon: Icons.chat_bubble_outline,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 12.h),
                        _SettingRow(
                          icon: Icons.tune,
                          title: 'Settings',
                          subtitle: 'Customize your workspace',
                          onTap: () {
                            context.pushNamed(RouteName.settingsScreen);
                          },
                        ),
                        SizedBox(height: 10.h),
                        _SettingRow(
                          icon: Icons.notifications_none,
                          title: 'Notifications',
                          subtitle: 'Stay updated with new insights',
                          onTap: () {
                            context.pushNamed(RouteName.notificationsScreen);
                          },
                        ),
                        SizedBox(height: 10.h),
                        _SettingRow(
                          icon: Icons.lock_outline,
                          title: 'Privacy',
                          subtitle: 'Secure your account and data',
                          onTap: () async {
                            await _launchExternalUrl(
                              context,
                              'https://firebase.google.com/support/privacy',
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        _SettingRow(
                          icon: Icons.help_outline,
                          title: 'Help & Support',
                          subtitle: 'Contact us for assistance',
                          onTap: () async {
                            await _launchExternalUrl(
                              context,
                              'https://support.google.com',
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await context.read<AuthCubit>().signOut();
                              if (context.mounted) {
                                context.goNamed(RouteName.authScreen);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffB5C4FF),
                              foregroundColor: const Color(0xff111319),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            icon: const Icon(Icons.logout),
                            label: Text(
                              'Sign out',
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class _ProfileChip extends StatelessWidget {
  const _ProfileChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xff242734),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15.sp, color: const Color(0xffB5C4FF)),
          SizedBox(width: 6.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xffE2E2EB),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff1C1E28),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xffB5C4FF), size: 20.sp),
          SizedBox(height: 14.h),
          Text(
            value,
            style: GoogleFonts.geist(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xffE2E2EB),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
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

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xff1C1E28),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xff2A2D3A)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xff242734),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: const Color(0xffB5C4FF)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffE2E2EB),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xffC3C5D7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: const Color(0xffC3C5D7),
            ),
          ],
        ),
      ),
    );
  }
}
