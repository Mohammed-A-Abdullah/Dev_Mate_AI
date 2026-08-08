import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive_layout.dart';
import 'onboarding_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            context.goNamed(RouteName.authScreen);
          }
        },
        child: ResponsiveLayout(
          mobile: OnboardingView(
            pageController: _pageController,
            maxContentWidth: 420,
            iconSize: 100,
            titleFontSize: 24,
            descriptionFontSize: 15,
            buttonWidth: double.infinity,
            horizontalPadding: 20,
            isDesktop: false,
          ),

          tablet: OnboardingView(
            pageController: _pageController,
            maxContentWidth: 650,
            iconSize: 140,
            titleFontSize: 32,
            descriptionFontSize: 18,
            buttonWidth: 420,
            horizontalPadding: 32,
            isDesktop: false,
          ),

          desktop: OnboardingView(
            pageController: _pageController,
            maxContentWidth: 1000,
            iconSize: 180,
            titleFontSize: 42,
            descriptionFontSize: 20,
            buttonWidth: 460,
            horizontalPadding: 40,
            isDesktop: true,
          ),
        ),
      ),
    );
  }
}
