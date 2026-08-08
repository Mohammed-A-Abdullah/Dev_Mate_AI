import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/responsive/responsive_layout.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/social_login_button.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isSignUp = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.goNamed(RouteName.navigationBar);
          }

          if (state is AuthError) {
            CustomSnackBar.error(context, message: state.message);
          }

          if (state is AuthSuccess) {
            CustomSnackBar.success(context, message: state.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,

              body: SafeArea(
                child: ResponsiveLayout(
                  mobile: _AuthMobileLayout(
                    state: state,
                    cubit: cubit,
                    isSignUp: isSignUp,
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onToggleMode: _toggleAuthMode,
                  ),

                  tablet: _AuthTabletLayout(
                    state: state,
                    cubit: cubit,
                    isSignUp: isSignUp,
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onToggleMode: _toggleAuthMode,
                  ),

                  desktop: _AuthDesktopLayout(
                    state: state,
                    cubit: cubit,
                    isSignUp: isSignUp,
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onToggleMode: _toggleAuthMode,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _toggleAuthMode() {
    FocusScope.of(context).unfocus();

    setState(() {
      isSignUp = !isSignUp;
    });
  }
}

class _AuthMobileLayout extends StatelessWidget {
  final AuthState state;
  final AuthCubit cubit;

  final bool isSignUp;

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onToggleMode;

  const _AuthMobileLayout({
    required this.state,
    required this.cubit,
    required this.isSignUp,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onToggleMode,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: _AuthContent(
        state: state,
        cubit: cubit,
        isSignUp: isSignUp,
        formKey: formKey,
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        onToggleMode: onToggleMode,
        maxWidth: double.infinity,
        horizontalPadding: 24,
        logoSize: 100,
        titleSize: 30,
        descriptionSize: 15,
        buttonHeight: 50,
        isDesktop: false,
      ),
    );
  }
}

class _AuthTabletLayout extends StatelessWidget {
  final AuthState state;
  final AuthCubit cubit;

  final bool isSignUp;

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onToggleMode;

  const _AuthTabletLayout({
    required this.state,
    required this.cubit,
    required this.isSignUp,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onToggleMode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: _AuthContent(
          state: state,
          cubit: cubit,
          isSignUp: isSignUp,
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          onToggleMode: onToggleMode,
          maxWidth: 520,
          horizontalPadding: 32,
          logoSize: 120,
          titleSize: 34,
          descriptionSize: 17,
          buttonHeight: 52,
          isDesktop: false,
        ),
      ),
    );
  }
}

class _AuthDesktopLayout extends StatelessWidget {
  final AuthState state;
  final AuthCubit cubit;

  final bool isSignUp;

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onToggleMode;

  const _AuthDesktopLayout({
    required this.state,
    required this.cubit,
    required this.isSignUp,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onToggleMode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100, maxHeight: 750),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100, maxHeight: 750),
            child: Row(
              children: [
                Expanded(flex: 5, child: _AuthBranding()),

                const SizedBox(width: 70),

                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: _AuthContent(
                      state: state,
                      cubit: cubit,
                      isSignUp: isSignUp,
                      formKey: formKey,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      onToggleMode: onToggleMode,
                      maxWidth: 450,
                      horizontalPadding: 0,
                      logoSize: 80,
                      titleSize: 34,
                      descriptionSize: 15,
                      buttonHeight: 52,
                      isDesktop: true,
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

class _AuthBranding extends StatelessWidget {
  const _AuthBranding();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),

        color: theme.colorScheme.primary.withValues(alpha: .06),

        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: .12),
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SvgPicture.asset(AppAssets.logo, width: 150),

          const SizedBox(height: 35),

          Text(
            'Dev Mate AI',
            textAlign: TextAlign.center,
            style: GoogleFonts.geist(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),

          const SizedBox(height: 20),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Text(
              'Your AI-powered developer assistant',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                height: 1.6,
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthContent extends StatelessWidget {
  final AuthState state;
  final AuthCubit cubit;

  final bool isSignUp;

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onToggleMode;

  final double maxWidth;
  final double horizontalPadding;
  final double logoSize;
  final double titleSize;
  final double descriptionSize;
  final double buttonHeight;

  final bool isDesktop;

  const _AuthContent({
    required this.state,
    required this.cubit,
    required this.isSignUp,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onToggleMode,
    required this.maxWidth,
    required this.horizontalPadding,
    required this.logoSize,
    required this.titleSize,
    required this.descriptionSize,
    required this.buttonHeight,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final currentState = state;

    final isSignUpLoading =
        currentState is AuthLoading && currentState.action == AuthAction.signUp;
    final isSignInLoading =
        currentState is AuthLoading && currentState.action == AuthAction.signIn;
    final isGoogleLoading =
        currentState is AuthLoading && currentState.action == AuthAction.google;
    final isGithubLoading =
        currentState is AuthLoading && currentState.action == AuthAction.github;
    final isGuestLoading =
        currentState is AuthLoading && currentState.action == AuthAction.guest;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),

        child: Column(
          children: [
            if (!isDesktop) const SizedBox(height: 20),

            /// Logo
            SvgPicture.asset(AppAssets.logo, width: logoSize),

            SizedBox(height: isDesktop ? 20 : 25),

            /// Title
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),

              child: Text(
                isSignUp ? local.createAccount : local.welcomBack,

                key: ValueKey(isSignUp),

                textAlign: TextAlign.center,

                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.secondary,

                  fontSize: titleSize,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Description
            Text(
              isSignUp ? local.signupText : local.signinText,

              textAlign: TextAlign.center,

              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSecondary,

                fontSize: descriptionSize,

                fontWeight: FontWeight.w500,

                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            /// Form
            Form(
              key: formKey,

              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),

                child: isSignUp
                    ? SignUpForm(
                        key: const ValueKey('signup'),

                        isLoading: isSignUpLoading,

                        formKey: formKey,

                        nameController: nameController,

                        emailController: emailController,

                        passwordController: passwordController,

                        confirmPasswordController: confirmPasswordController,

                        onSubmit: () {
                          FocusScope.of(context).unfocus();

                          if (formKey.currentState!.validate()) {
                            cubit.signUp(
                              name: nameController.text.trim(),

                              email: emailController.text.trim(),

                              password: passwordController.text,
                            );
                          }
                        },
                      )
                    : SignInForm(
                        key: const ValueKey('signin'),

                        isLoading: isSignInLoading,

                        formKey: formKey,

                        emailController: emailController,

                        passwordController: passwordController,

                        onSubmit: () {
                          FocusScope.of(context).unfocus();

                          if (formKey.currentState!.validate()) {
                            cubit.signIn(
                              email: emailController.text.trim(),

                              password: passwordController.text,
                            );
                          }
                        },
                      ),
              ),
            ),

            /// Forgot Password
            if (!isSignUp)
              Align(
                alignment: AlignmentDirectional.centerEnd,

                child: TextButton(
                  onPressed: () {
                    context.pushNamed(RouteName.sendEmailForPassword);
                  },

                  child: Text(
                    local.forgetPassword,

                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.secondary,

                      fontSize: isDesktop ? 14 : 13,
                    ),
                  ),
                ),
              ),

            SizedBox(height: isDesktop ? 20 : 25),

            /// OR
            Row(
              children: [
                Expanded(
                  child: Divider(color: Theme.of(context).colorScheme.outline),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),

                  child: Text(
                    local.or,

                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,

                      fontSize: isDesktop ? 14 : 13,
                    ),
                  ),
                ),

                Expanded(
                  child: Divider(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),

            SizedBox(height: isDesktop ? 20 : 25),

            /// Google
            SocialLoginButton.google(
              onTap: cubit.googleSignIn,

              isLoading: isGoogleLoading,
            ),

            const SizedBox(height: 12),

            /// GitHub
            SocialLoginButton.github(
              onTap: cubit.githubSignIn,

              isLoading: isGithubLoading,
            ),

            const SizedBox(height: 12),

            /// Guest
            SocialLoginButton.guest(
              onTap: cubit.guestSignIn,

              isLoading: isGuestLoading,
            ),

            const SizedBox(height: 25),

            /// Toggle Sign In / Sign Up
            GestureDetector(
              onTap: onToggleMode,

              child: RichText(
                textAlign: TextAlign.center,

                text: TextSpan(
                  children: [
                    TextSpan(
                      text: isSignUp
                          ? local.haveAnAccount
                          : local.dontHaveAccount,

                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,

                        fontSize: isDesktop ? 14 : 13,
                      ),
                    ),

                    TextSpan(
                      text: isSignUp ? local.signin : local.signup,

                      style: GoogleFonts.jetBrainsMono(
                        color: Theme.of(context).colorScheme.primary,

                        fontWeight: FontWeight.bold,

                        fontSize: isDesktop ? 13 : 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
