import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:dev_mate_ai/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:dev_mate_ai/features/auth/presentation/widgets/sign_up_form.dart';
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSignUp = false;

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
      create: (context) => AuthCubit(
        checkAuthStatusUseCase: CheckAuthStatusUseCase(AuthRepositoryImpl()),
        signInUseCase: SignInUseCase(AuthRepositoryImpl()),
        signUpUseCase: SignUpUseCase(AuthRepositoryImpl()),
        signOutUseCase: SignOutUseCase(AuthRepositoryImpl()),
      )..checkAuthStatus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.goNamed(RouteName.navigationBar);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

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
                      if (_isSignUp)
                        SignUpForm(
                          nameController: _nameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          formKey: _formKey,
                          onSubmit: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.submitSignUp(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                        )
                      else
                        SignInForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey,
                          onSubmit: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.submitSignIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
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
                      HeightSpace(height: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                          });
                        },
                        child: Text.rich(
                          _isSignUp
                              ? TextSpan(
                                  text: 'Already have an account? ',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xffB5C4FF),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Sign in',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xffE2E2EB),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              : TextSpan(
                                  text: 'Need an account? ',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xffB5C4FF),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Sign up',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xffE2E2EB),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      HeightSpace(height: 24),
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
