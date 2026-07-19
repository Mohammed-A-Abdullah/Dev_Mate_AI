import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/route_name.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_up_form.dart';
import '../widgets/social_login_button.dart';

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
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.goNamed(RouteName.navigationBar);
          }

          if (state is AuthError) {
            CustomSnackBar.show(
              context,
              message: "Authentication failed.",
              backgroundColor: Theme.of(context).colorScheme.error,
            );
          }

          if (state is AuthSuccess) {
            
            CustomSnackBar.show(
              context,
              message: "Authentication successful!",
              backgroundColor: AppColors.success,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 32.h,
                    ),
                    child: Column(
                      children: [
                        HeightSpace(height: 20.h),

                        SvgPicture.asset(AppAssets.logo, width: 100.w),

                        HeightSpace(height: 25.h),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: Text(
                            isSignUp ? "Create Account" : "Welcome Back",
                            key: ValueKey(isSignUp),
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        HeightSpace(height: 10.h),

                        Text(
                          isSignUp
                              ? "Create your DevMate AI account."
                              : "Continue your AI journey.",
                          style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        HeightSpace(height: 35.h),

                        Form(
                          key: _formKey,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: isSignUp
                                ? SignUpForm(
                                    key: const ValueKey(1),
                                    formKey: _formKey,
                                    nameController: _nameController,
                                    emailController: _emailController,
                                    passwordController: _passwordController,
                                    confirmPasswordController:
                                        _confirmPasswordController,
                                    onSubmit: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.signUp(
                                          name: _nameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                        );
                                      }
                                    },
                                  )
                                : SignInForm(
                                    key: const ValueKey(2),
                                    formKey: _formKey,
                                    emailController: _emailController,
                                    passwordController: _passwordController,
                                    onSubmit: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.signIn(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ),

                        if (!isSignUp)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                               GoRouter.of(context).pushNamed(RouteName.sendEmailForPassword);
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.inter(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),

                        HeightSpace(height: 30.h),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),

                        HeightSpace(height: 30.h),

                        SocialLoginButton.google(onTap: cubit.googleSignIn),

                        HeightSpace(height: 16.h),

                        SocialLoginButton.github(onTap: cubit.githubSignIn),

                        HeightSpace(height: 16.h),

                        SocialLoginButton.guest(onTap: cubit.guestSignIn),

                        HeightSpace(height: 35.h),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUp = !isSignUp;
                            });
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: isSignUp
                                      ? "Already have an account? "
                                      : "Don't have an account? ",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: isSignUp ? "Sign In" : "Sign Up",
                                  style: GoogleFonts.jetBrainsMono(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        HeightSpace(height: 30.h),
                      ],
                    ),
                  ),

                  if (state is AuthLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
