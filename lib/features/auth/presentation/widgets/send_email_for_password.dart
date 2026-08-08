import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/responsive/responsive_layout.dart';

class SendEmailForPassword extends StatefulWidget {
  const SendEmailForPassword({super.key});

  @override
  State<SendEmailForPassword> createState() => _SendEmailForPasswordState();
}

class _SendEmailForPasswordState extends State<SendEmailForPassword> {
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail(BuildContext context) {
    final local = S.of(context);

    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();

    if (email.isEmpty) {
      CustomSnackBar.error(context, message: local.showDialogSendEmail);

      return;
    }

    context.read<AuthCubit>().resetPassword(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),

      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackBar.error(
              context,
              message: 'Failed to send reset email.',
            );
          }

          if (state is AuthSuccess &&
              state.message == 'PASSWORD_RESET_EMAIL_SENT') {
            context.pushNamed(
              RouteName.checkEmailScreen,
              extra: emailController.text.trim(),
            );
          }
        },

        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },

            child: Scaffold(
              appBar: AppBar(),

              body: SafeArea(
                child: ResponsiveLayout(
                  mobile: _ForgotPasswordContent(
                    emailController: emailController,
                    formKey: formKey,
                    isLoading: state is AuthLoading,
                    onSubmit: () => _sendResetEmail(context),
                    maxWidth: double.infinity,
                    horizontalPadding: 24,
                    logoSize: 90,
                    titleSize: 24,
                    descriptionSize: 13,
                    buttonHeight: 50,
                  ),

                  tablet: _ForgotPasswordContent(
                    emailController: emailController,
                    formKey: formKey,
                    isLoading: state is AuthLoading,
                    onSubmit: () => _sendResetEmail(context),
                    maxWidth: 480,
                    horizontalPadding: 32,
                    logoSize: 100,
                    titleSize: 30,
                    descriptionSize: 15,
                    buttonHeight: 52,
                  ),

                  desktop: _ForgotPasswordContent(
                    emailController: emailController,
                    formKey: formKey,
                    isLoading: state is AuthLoading,
                    onSubmit: () => _sendResetEmail(context),
                    maxWidth: 500,
                    horizontalPadding: 40,
                    logoSize: 110,
                    titleSize: 34,
                    descriptionSize: 16,
                    buttonHeight: 54,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ForgotPasswordContent extends StatelessWidget {
  const _ForgotPasswordContent({
    required this.emailController,
    required this.formKey,
    required this.isLoading,
    required this.onSubmit,
    required this.maxWidth,
    required this.horizontalPadding,
    required this.logoSize,
    required this.titleSize,
    required this.descriptionSize,
    required this.buttonHeight,
  });

  final TextEditingController emailController;

  final GlobalKey<FormState> formKey;

  final bool isLoading;

  final VoidCallback onSubmit;

  final double maxWidth;
  final double horizontalPadding;

  final double logoSize;

  final double titleSize;
  final double descriptionSize;

  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 30,
          ),

          child: Form(
            key: formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                /// Logo
                SvgPicture.asset(
                  AppAssets.logo,
                  width: logoSize,
                  height: logoSize,
                ),

                const SizedBox(height: 30),

                /// Title
                Text(
                  local.forgetpasswordEmail,

                  textAlign: TextAlign.center,

                  style: GoogleFonts.inter(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 12),

                /// Description
                Text(
                  local.sendEmailPassword,

                  textAlign: TextAlign.center,

                  style: GoogleFonts.inter(
                    fontSize: descriptionSize,

                    height: 1.6,

                    color: theme.colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 32),

                /// Email field
                CustomTextField(
                  controller: emailController,

                  isPassword: false,

                  keyBoardType: TextInputType.emailAddress,

                  hintText: local.email,

                  prefixIcon: const Icon(Icons.email_outlined),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return local.showDialogSendEmail;
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                /// Send button
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,

                  child: ElevatedButton(
                    onPressed: isLoading ? null : onSubmit,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,

                      foregroundColor: theme.colorScheme.onPrimary,

                      disabledBackgroundColor: theme.colorScheme.primary
                          .withValues(alpha: .6),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),

                      child: isLoading
                          ? SizedBox(
                              key: const ValueKey('loading'),

                              width: 20,
                              height: 20,

                              child: CircularProgressIndicator(
                                strokeWidth: 2,

                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              key: const ValueKey('text'),

                              local.checkEmail,

                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 13,

                                fontWeight: FontWeight.w600,

                                letterSpacing: .5,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Back button
                TextButton(
                  onPressed: () {
                    context.pop();
                  },

                  child: Text(
                    local.backToSignIn,

                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,

                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
