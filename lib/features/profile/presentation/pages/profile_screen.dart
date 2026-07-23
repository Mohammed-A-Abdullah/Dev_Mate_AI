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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void> _showImagePicker(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) {
        return ImagePickerDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
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
                    HeightSpace(height: 20),
                    Center(
                      child: Column(
                        children: [
                          CustomImageSection(onTap: () => _showImagePicker,photoUrl: photoUrl,),
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
                            label: "Chats",
                            valueColor: const Color(0xffB5C4FF),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomStateCard(
                            value: profile.readmes.toString(),
                            label: "READMEs",
                            valueColor: const Color(0xffC79DFF),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomStateCard(
                            value: profile.analysis.toString(),
                            label: "Analysis",
                            valueColor: const Color(0xff6EE7B7),
                          ),
                        ),
                      ],
                    ),

                    HeightSpace(height: 24.h),

                    CustomSettingGroupe(
                      onAccountSettingsTap: () {
                        context.pushNamed(RouteName.accountStettingsScreen);
                      },
                      onNotificationsTap: () {
                        context.pushNamed(RouteName.notificationsScreen);
                      },
                      onAboutTap: () async {
                        context.pushNamed(RouteName.aboutScreen);
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