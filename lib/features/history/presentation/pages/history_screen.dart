import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/constants/app_colors.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_ai_model_answer_screen.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/history/data/datasource/history_remote_data_source_impl.dart';
import 'package:dev_mate_ai/features/history/data/repositories/history_repository_impl.dart';
import 'package:dev_mate_ai/features/history/domain/usecases/get_history_use_case.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_card_widget.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_text_field.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_tab_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HistoryCubit>(),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late final TextEditingController historController;
  late final List<String> filterChip;

  @override
  void initState() {
    super.initState();
    historController = TextEditingController();
    filterChip = [
      'All',
      'Chat',
      'README',
      'Code Review',
      'Project Planner',
      'Debug',
    ];
    context.read<HistoryCubit>().loadHistory();
  }

  @override
  void dispose() {
    historController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'DevMate AI'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(height: 24),
              Text(
                'Activity History',
                style: GoogleFonts.geist(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffE2E2EB).withValues(alpha: 0.9),
                ),
              ),
              HeightSpace(height: 16),
              CustomHistoryTextField(controller: historController),
              HeightSpace(height: 32),
              SizedBox(
                height: 33.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterChip.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CustomTabBarWidget(
                      text: filterChip[index],
                      onTap: () {},
                      isSelected: true,
                    );
                  },
                ),
              ),
              HeightSpace(height: 32),
              BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is HistoryLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        final item = state.history[index];

                        return CustomHistoryCardWidget(
                          title: item.title.isEmpty ? 'New Chat' : item.title,
                          description: item.lastMessage.isEmpty
                              ? 'No messages yet'
                              : item.lastMessage,
                          chipType: item.type,
                          time: item.updatedAt,
                          onTap: () {
                            if (item.type.toLowerCase() == 'chat') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(chatId: item.id),
                                ),
                              );
                            } else {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => CustomAiModelAnswerScreen(
                              //       cubit: item.lastMessage,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                        );
                      },
                    );
                  }

                  if (state is HistoryError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
