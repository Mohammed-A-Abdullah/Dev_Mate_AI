import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/features/onboarding/presentation/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../../splash/data/datasources/splash_local_data_source.dart';
import '../../../splash/data/repositories/splash_repository_impl.dart';
import '../../../splash/domain/usecases/check_onboarding.dart';
import '../../../splash/domain/usecases/save_onboarding_completed.dart';
import '../../../splash/presentation/cubit/splash_cubit.dart';
import '../../../splash/presentation/cubit/splash_state.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_page_content.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>sl<OnboardingCubit>(),
        ),
        BlocProvider(
          create: (context) {
            final repository = SplashRepositoryImpl(
              SplashLocalDataSourceImpl(),
            );
            return SplashCubit(
              CheckOnboarding(repository),
              SaveOnboardingCompleted(repository),
            );
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final cubit = context.read<OnboardingCubit>();

          return BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state is SplashGoToOnboarding) {
                context.goNamed(RouteName.onboardingScreen);
                return;
              }

              if (state is SplashGoToAuth) {
                context.goNamed(RouteName.authScreen);
                return;
              }

              if (state is SplashGoToChat) {
                context.goNamed(RouteName.navigationBar);
              }
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      HeightSpace(height: 25),

                      SkipButton(),

                      HeightSpace(height: 90),

                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: cubit.onboardingPages.length,
                          onPageChanged: cubit.onPageChanged,
                          itemBuilder: (context, index) {
                            return OnboardingPageContent(
                              pageData: cubit.onboardingPages[index],
                            );
                          },
                        ),
                      ),

                      SmoothPageIndicator(
                        controller: _pageController,
                        count: cubit.onboardingPages.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          dotHeight: 8.h,
                          dotWidth: 8.w,
                          dotColor: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),

                      HeightSpace(height: 40),

                      BlocBuilder<OnboardingCubit, OnboardingState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () async {
                              if (state.isLastPage) {
                                await context
                                    .read<SplashCubit>()
                                    .finishOnboarding();
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.isLastPage ? 'Get Started' : 'NEXT',
                                    style: GoogleFonts.jetBrainsMono(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.55.sp,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    state.isLastPage
                                        ? Icons.rocket_launch
                                        : Icons.arrow_forward,
                                    size: 16.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      HeightSpace(height: 30),
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
