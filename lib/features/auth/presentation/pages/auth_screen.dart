import 'package:dev_mate_ai/features/chat_screen/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/route_name.dart';
import '../../data/datasources/firebase_auth_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/send_email_verification_usecase.dart';
import '../../domain/usecases/sign_in_github_usecase.dart';
import '../../domain/usecases/sign_in_google_usecase.dart';
import '../../domain/usecases/sign_in_guest_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
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

  void showSnack(String message, {bool error = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? Colors.red : Colors.green,
          content: Text(message),
        ),
      );
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
            showSnack(state.message, error: true);
          }

          if (state is AuthSuccess) {
            showSnack(state.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          return Scaffold(
            backgroundColor: const Color(0xff111319),
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
                        SizedBox(height: 20.h),

                        Hero(
                          tag: "logo",
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: const Color(0xff1E222D),
                            child: Icon(
                              Icons.smart_toy_rounded,
                              size: 40.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 25.h),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: Text(
                            isSignUp ? "Create Account" : "Welcome Back",
                            key: ValueKey(isSignUp),
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        Text(
                          isSignUp
                              ? "Create your DevMate AI account."
                              : "Continue your AI journey.",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15.sp,
                          ),
                        ),

                        SizedBox(height: 35.h),

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
                                //context.pushNamed(RouteName.forgotPassword);
                              },
                              child: const Text("Forgot Password?"),
                            ),
                          ),

                        SizedBox(height: 30.h),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(color: Colors.grey.shade700),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(color: Colors.grey.shade700),
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),

                        SocialLoginButton.google(onTap: cubit.googleSignIn),

                        SizedBox(height: 16.h),

                        SocialLoginButton.github(onTap: cubit.githubSignIn),

                        SizedBox(height: 16.h),

                        SocialLoginButton.guest(onTap: cubit.guestSignIn),

                        SizedBox(height: 35.h),

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
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: isSignUp ? "Sign In" : "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),

                  if (state is AuthLoading)
                    Container(
                      color: Colors.black54,
                      child: const Center(child: CircularProgressIndicator()),
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
