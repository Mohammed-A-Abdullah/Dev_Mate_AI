import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/theme/extensions/splash_theme_extension.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_linear_progress_widget.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_logo_with_shadow_widget.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_title_description.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routing/route_name.dart';
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
      create: (_) {

        return sl<SplashCubit>()..start();
      },

      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashGoToOnboarding) {
            context.goNamed(RouteName.onboardingScreen);
          }

          if (state is SplashGoToAuth) {
            context.goNamed(RouteName.authScreen);
          }

          if (state is SplashGoToChat) {
            context.goNamed(RouteName.navigationBar);
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
                      S.of(context).POWERED_BY_ADVANCED_LLMS,
                      style: GoogleFonts.jetBrainsMono(
                        color: Theme.of(context).extension<SplashThemeExtension>()!.splashText,
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
