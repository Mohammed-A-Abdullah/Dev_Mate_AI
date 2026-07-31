import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_card_widget.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_text_field.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_tab_bar_widget.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
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
  late final TextEditingController historyController;
  late final List<String> filterChips;

  int selectedFilterIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    historyController = TextEditingController();

    filterChips = [
      'All',
      'Chat',
      'Generate README',
      'Code Review',
      'Project Planner',
      'Debug',
    ];

    historyController.addListener(_onSearchChanged);

    context.read<HistoryCubit>().loadHistory();
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = historyController.text.trim().toLowerCase();
    });
  }

  @override
  void dispose() {
    historyController.removeListener(_onSearchChanged);
    historyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: local.history, needButton: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeightSpace(height: 24),
            Text(
              local.activityHistory,
              style: GoogleFonts.geist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            HeightSpace(height: 16),
            CustomHistoryTextField(controller: historyController),
            HeightSpace(height: 20),

            SizedBox(
              height: 35.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filterChips.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  return CustomTabBarWidget(
                    text: filterChips[index],
                    isSelected: selectedFilterIndex == index,
                    onTap: () {
                      setState(() {
                        selectedFilterIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            HeightSpace(height: 20),

            Expanded(
              child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }

                  if (state is HistoryLoaded) {
                    final filteredHistory = state.history.where((item) {
                      final matchesType =
                          selectedFilterIndex == 0 ||
                          item.type.toLowerCase() ==
                              filterChips[selectedFilterIndex].toLowerCase();

                      final matchesQuery =
                          searchQuery.isEmpty ||
                          item.title.toLowerCase().contains(searchQuery) ||
                          item.lastMessage.toLowerCase().contains(searchQuery);

                      return matchesType && matchesQuery;
                    }).toList();

                    if (filteredHistory.isEmpty) {
                      return Center(
                        child: Text(
                          'No history found',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredHistory.length,
                      itemBuilder: (context, index) {
                        final item = filteredHistory[index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: CustomHistoryCardWidget(
                            title: item.title.isEmpty
                                ? local.newChat
                                : item.title,
                            description: item.lastMessage.isEmpty
                                ? local.noMessageYet
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
                              } else {}
                            },
                          ),
                        );
                      },
                    );
                  }

                  if (state is HistoryError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
