import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_state.dart';
import 'package:dev_mate_ai/features/home/data/repository/home_repository_imp.dart';
import 'package:dev_mate_ai/features/home/presentation/cubit/home_cubit.dart';
import 'package:dev_mate_ai/features/home/presentation/widgets/custom_new_chat_container.dart';
import 'package:dev_mate_ai/features/home/presentation/widgets/quick_tool_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/route_name.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(HomeRepositoryImp())..loadHomeData(),
        ),
        BlocProvider(
          create: (context) =>
              AuthCubit(AuthRepositoryImpl())..checkAuthStatus(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xff111319),
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
                  icon: const Icon(Icons.logout, color: Color(0xffB5C4FF)),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xffB5C4FF)),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.redAccent),
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
                        CustomTextField(
                          borderColor: Color(0xff434654),
                          fillColor: Color(0xff1E1F26),
                          hintText: 'Search features or history...',
                          hintTextStyle: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Color(0xff434654),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xffC3C5D7),
                            size: 20.sp,
                          ),
                          radius: 50.r,
                        ),
                        HeightSpace(height: 32),
                        Text(
                          'Good morning',
                          style: GoogleFonts.geist(
                            fontSize: 24.sp,
                            color: Color(0xffE2E2EB),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Ready to build something amazing today?',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Color(0xffC3C5D7),
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
                            color: Color(0xffE2E2EB),
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
                                color: Color(0xffE2E2EB),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'View All',
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB5C4FF),
                                  letterSpacing: 0.55.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeightSpace(height: 22),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          width: 100,
                          color: Colors.amber,
                          child: Text('data'),
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
