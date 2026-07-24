import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class SendEmailForPassword extends StatelessWidget {
  SendEmailForPassword({super.key});

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackBar.show(
              context,
              message: "Failed to send reset email.",
              backgroundColor: Theme.of(context).colorScheme.error,
            );
          }
          if (state is AuthSuccess &&
              state.message == "PASSWORD_RESET_EMAIL_SENT") {
            context.pushNamed(
              RouteName.checkEmailScreen,
              extra: emailController.text.trim(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeightSpace(height: 20.h),

                    SvgPicture.asset(AppAssets.logo, width: 100.w),

                    HeightSpace(height: 25.h),
                    HeightSpace(height: 20),
                    Text(
                      local.forgetpasswordEmail,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    HeightSpace(height: 10),
                    Text(
                      local.sendEmailPassword,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    HeightSpace(height: 32),
                    CustomTextField(
                      controller: emailController,
                      isPassword: false,
                      hintText: local.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    HeightSpace(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        onPressed: state is AuthLoading
                            ? null 
                            : () {
                                final email = emailController.text.trim();

                                if (email.isEmpty) {
                                  CustomSnackBar.show(
                                    context,
                                    message:
                                        local.showDialogSendEmail,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.error,
                                  );
                                  return;
                                }

                                context.read<AuthCubit>().resetPassword(email);
                              },
                        child: state is AuthLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                local.checkEmail,
                                style: GoogleFonts.jetBrainsMono(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
