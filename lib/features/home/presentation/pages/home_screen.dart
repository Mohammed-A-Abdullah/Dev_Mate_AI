import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:dev_mate_ai/features/home/presentation/cubit/home_cubit.dart';
import 'package:dev_mate_ai/features/home/presentation/widgets/custom_new_chat_container.dart';
import 'package:dev_mate_ai/features/home/presentation/widgets/quick_tool_item.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/route_name.dart';
import '../../../history/presentation/widgets/custom_history_card_widget.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<HomeCubit>()..loadHomeData()),
        BlocProvider(create: (context) => sl<AuthCubit>()..checkAuthStatus()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff111319),
          title: Text(
            'DevMate AI',
            style: GoogleFonts.geist(
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffB5C4FF),
            ),
          ),
          actions: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    await context.read<AuthCubit>().signOut();
                    if (context.mounted) {
                      context.goNamed(RouteName.authScreen);
                    }
                  },
                  icon: const Icon(Icons.logout, color: AppColors.primaryColor),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: AppColors.error),
                ),
              );
            }

            if (state is HomeLoaded) {
              return SafeArea(
                bottom: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeightSpace(height: 24),
                        // CustomTextField(
                        //   borderColor: AppColors.borderColor,
                        //   fillColor: AppColors.fillColor,
                        //   hintText: 'Search features or history...',
                        //   hintTextStyle: GoogleFonts.inter(
                        //     fontSize: 14.sp,
                        //     color: AppColors.hintText,
                        //   ),
                        //   prefixIcon: Icon(
                        //     Icons.search,
                        //     color: AppColors.iconField,
                        //     size: 20.sp,
                        //   ),
                        //   radius: 50.r,
                        // ),
                        Text(
                          'Good morning, ${currentUser?.displayName ?? "User"} ',
                          style: GoogleFonts.geist(
                            fontSize: 24.sp,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Ready to build something amazing today?',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        HeightSpace(height: 32),
                        CustomNewChatContainer(),
                        HeightSpace(height: 32),
                        Text(
                          'Quick Tools',
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                          ),
                        ),
                        HeightSpace(height: 16),
                        GridView.builder(
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 16.h,
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: state.quickTools.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return QuickToolItem(tool: state.quickTools[index]);
                          },
                        ),
                        HeightSpace(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Activity',
                              style: GoogleFonts.inter(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<NavigationCubit>().changeIndex(2);
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                  letterSpacing: 0.55.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeightSpace(height: 22),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return CustomHistoryCardWidget(
                              title: 'New Chat',
                              description: 'No messages yet',

                              chipType: 'chat',
                              time: DateTime(2026),
                              onTap: () {},
                            );
                          },
                        ),
                        HeightSpace(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
