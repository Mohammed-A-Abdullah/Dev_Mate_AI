import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/responsive/responsive_layout.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:dev_mate_ai/features/splash/presentation/cubit/splash_state.dart';
import 'package:dev_mate_ai/features/splash/presentation/pages/splash_screens/splash_desktop.dart';
import 'package:dev_mate_ai/features/splash/presentation/pages/splash_screens/splash_mobile.dart';
import 'package:dev_mate_ai/features/splash/presentation/pages/splash_screens/splash_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SplashCubit>()..start(),
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
        child: const ResponsiveLayout(
          mobile: SplashMobile(),
          tablet: SplashTablet(),
          desktop: SplashDesktop(),
        ),
      ),
    );
  }
}
