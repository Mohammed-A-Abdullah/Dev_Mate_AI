import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/splash/domain/usecases/check_onboarding.dart';
import 'package:dev_mate_ai/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_linear_progress_widget.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_logo_with_shadow_widget.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_title_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routing/route_name.dart';
import '../../data/datasources/splash_local_data_source.dart';
import '../../data/repositories/splash_repository_impl.dart';
import '../cubit/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        CheckOnboarding(SplashRepositoryImpl(SplashLocalDataSourceImpl())),
      )..start(),

      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashGoToChat) {
            context.goNamed(RouteName.navigationBar);
          }

          if (state is SplashGoToOnboarding) {
            context.goNamed(RouteName.onboardingScreen);
          }

          if (state is SplashGoToAuth) {
            context.goNamed(RouteName.authScreen);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                AppAssets.background,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withValues(alpha: 0.3),
              ),
              Center(
                child: Column(
                  children: [
                    HeightSpace(height: 310),
                    CustomLogoWithShadowWidget(),
                    HeightSpace(height: 32),
                    CustomTitleDescription(),
                    Spacer(),
                    CustomLinearProgressWidget(),
                    HeightSpace(height: 24),
                    Text(
                      'POWERED BY ADVANCED LLMS',
                      style: GoogleFonts.jetBrainsMono(
                        color: Color(0xff8D90A0),
                        fontSize: 11.sp,
                        letterSpacing: 1.1.sp,
                      ),
                    ),
                    HeightSpace(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
