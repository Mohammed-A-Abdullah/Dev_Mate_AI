import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepositoryImpl())..checkAuthStatus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.goNamed(RouteName.navigationBar);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: const Color(0xff111319),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightSpace(height: 40),
                      Text(
                        _isSignUp ? 'Create your account' : 'Welcome back',
                        style: GoogleFonts.geist(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffE2E2EB),
                        ),
                      ),
                      HeightSpace(height: 8),
                      Text(
                        _isSignUp
                            ? 'Set up a local DevMate AI profile to keep your experience secure.'
                            : 'Sign in to continue building with DevMate AI.',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xffC3C5D7),
                          height: 1.5,
                        ),
                      ),
                      HeightSpace(height: 32),
                      CustomTextField(
                        controller: _emailController,
                        keyBoardType: TextInputType.emailAddress,
                        hintText: 'Email address',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xffC3C5D7),
                        ),
                        fillColor: const Color(0xff1E1F26),
                        borderColor: const Color(0xff434654),
                        radius: 18.r,
                        textStyle: GoogleFonts.inter(color: Colors.white),
                        hintTextStyle: GoogleFonts.inter(
                          color: const Color(0xff6F7385),
                          fontSize: 14.sp,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      HeightSpace(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        isPassword: true,
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xffC3C5D7),
                        ),
                        fillColor: const Color(0xff1E1F26),
                        borderColor: const Color(0xff434654),
                        radius: 18.r,
                        textStyle: GoogleFonts.inter(color: Colors.white),
                        hintTextStyle: GoogleFonts.inter(
                          color: const Color(0xff6F7385),
                          fontSize: 14.sp,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          if (!_isSignUp && value.trim().length < 1) {
                            return 'Password is required';
                          }
                          if (_isSignUp && value.trim().length < 6) {
                            return 'Use at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      HeightSpace(height: 24),
                      if (state is AuthError)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xff2A1B1B),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.redAccent),
                          ),
                          child: Text(
                            state.message,
                            style: GoogleFonts.inter(
                              color: Colors.redAccent,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      HeightSpace(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final email = _emailController.text.trim();
                                    final password = _passwordController.text
                                        .trim();

                                    if (_isSignUp) {
                                      cubit.submitSignUp(
                                        email: email,
                                        password: password,
                                      );
                                    } else {
                                      cubit.submitSignIn(
                                        email: email,
                                        password: password,
                                      );
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB5C4FF),
                            foregroundColor: const Color(0xff00297B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Color(0xff00297B),
                                )
                              : Text(
                                  _isSignUp ? 'Create account' : 'Sign in',
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.55.sp,
                                  ),
                                ),
                        ),
                      ),
                      HeightSpace(height: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                          });
                        },
                        child: Text(
                          _isSignUp
                              ? 'Already have an account? Sign in'
                              : 'Need an account? Sign up',
                          style: GoogleFonts.inter(
                            color: const Color(0xffB5C4FF),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      HeightSpace(height: 24),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: const Color(0xff1E1F26),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: const Color(0xff434654)),
                        ),
                        child: Text(
                          'This auth flow is kept local on your device for the demo experience.',
                          style: GoogleFonts.inter(
                            color: const Color(0xff8D90A0),
                            fontSize: 12.sp,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
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
