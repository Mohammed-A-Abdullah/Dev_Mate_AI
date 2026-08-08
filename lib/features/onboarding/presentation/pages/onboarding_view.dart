import 'package:dev_mate_ai/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/widgets/onboarding_page_content.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/widgets/skip_button.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatelessWidget {
  final PageController pageController;

  final double maxContentWidth;
  final double iconSize;
  final double titleFontSize;
  final double descriptionFontSize;
  final double buttonWidth;
  final double horizontalPadding;

  final bool isDesktop;

  const OnboardingView({
    super.key,
    required this.pageController,
    required this.maxContentWidth,
    required this.iconSize,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.buttonWidth,
    required this.horizontalPadding,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),

            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),

              child: Column(
                children: [
                  const SkipButton(),

                  const SizedBox(height: 20),

                  Expanded(
                    child: PageView.builder(
                      controller: pageController,

                      itemCount: cubit.onboardingPages.length,

                      onPageChanged: cubit.onPageChanged,

                      itemBuilder: (context, index) {
                        return OnboardingPageContent(
                          pageData: cubit.onboardingPages[index],

                          iconSize: iconSize,

                          titleFontSize: titleFontSize,

                          descriptionFontSize: descriptionFontSize,

                          isDesktop: isDesktop,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  SmoothPageIndicator(
                    controller: pageController,

                    count: cubit.onboardingPages.length,

                    effect: ExpandingDotsEffect(
                      spacing: 8,
                      radius: 50,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,

                      activeDotColor: Theme.of(context).colorScheme.primary,

                      dotColor: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),

                  const SizedBox(height: 35),

                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: buttonWidth,
                        height: 52,

                        child: FilledButton(
                          onPressed: () async {
                            if (state.isLastPage) {
                              await cubit.finishOnboarding();
                            } else {
                              await pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },

                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                state.isLastPage
                                    ? S.of(context).getStarted
                                    : S.of(context).next,

                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: isDesktop ? 15 : 14,

                                  fontWeight: FontWeight.w600,

                                  letterSpacing: .5,
                                ),
                              ),

                              const SizedBox(width: 8),

                              Icon(
                                state.isLastPage
                                    ? Icons.rocket_launch
                                    : Icons.arrow_forward,

                                size: isDesktop ? 20 : 18,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopOnboardingLayout extends StatelessWidget {
  final PageController pageController;

  final double maxContentWidth;
  final double iconSize;
  final double titleFontSize;
  final double descriptionFontSize;
  final double buttonWidth;
  final double horizontalPadding;

  const _DesktopOnboardingLayout({
    required this.pageController,
    required this.maxContentWidth,
    required this.iconSize,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.buttonWidth,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxContentWidth,
              maxHeight: 800,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 30,
              ),
              child: Column(
                children: [
                  const SkipButton(),

                  const SizedBox(height: 20),

                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: cubit.onboardingPages.length,
                      onPageChanged: cubit.onPageChanged,
                      itemBuilder: (context, index) {
                        return _DesktopPageContent(
                          pageData: cubit.onboardingPages[index],
                          iconSize: iconSize,
                          titleFontSize: titleFontSize,
                          descriptionFontSize: descriptionFontSize,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  _PageIndicator(
                    pageController: pageController,
                    count: cubit.onboardingPages.length,
                  ),

                  const SizedBox(height: 40),

                  _NextButton(
                    pageController: pageController,
                    width: buttonWidth,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _DesktopPageContent extends StatelessWidget {
  final dynamic pageData;

  final double iconSize;
  final double titleFontSize;
  final double descriptionFontSize;

  const _DesktopPageContent({
    required this.pageData,
    required this.iconSize,
    required this.titleFontSize,
    required this.descriptionFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                pageData.icon,
                size: iconSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(width: 60),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pageData.title,
                  style: GoogleFonts.geist(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 20),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Text(
                    pageData.description,
                    style: GoogleFonts.inter(
                      fontSize: descriptionFontSize,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int count;

  const _PageIndicator({required this.pageController, required this.count});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: ExpandingDotsEffect(
        spacing: 8,
        radius: 50,
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 3,
        activeDotColor: Theme.of(context).colorScheme.primary,
        dotColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
class _NextButton extends StatelessWidget {
  final PageController pageController;
  final double width;

  const _NextButton({required this.pageController, required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();

        return SizedBox(
          width: width,
          height: 52,
          child: FilledButton(
            onPressed: () async {
              if (state.isLastPage) {
                await cubit.finishOnboarding();
              } else {
                await pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.isLastPage
                      ? S.of(context).getStarted
                      : S.of(context).next,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  state.isLastPage ? Icons.rocket_launch : Icons.arrow_forward,
                  size: 18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
