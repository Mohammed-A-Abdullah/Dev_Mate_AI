import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_ai_model_answer_screen.dart';
import 'package:dev_mate_ai/features/chat_screen/presentation/pages/chat_screen.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/load_messages_usecase.dart';
import 'package:dev_mate_ai/features/history/domain/entity/history_entity.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_card_widget.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_text_field.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_tab_bar_widget.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';

/// Index of the History tab inside CustomNavigationBar's destinations
/// (Home=0, Chat=1, History=2, Profile=3).
const int _historyTabIndex = 2;

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

  Future<void> _openHistoryItem(
    BuildContext context,
    HistoryEntity item,
  ) async {
    if (item.type.toLowerCase() == 'chat') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatScreen(chatId: item.id, showBackButton: true),
        ),
      );
    } else {
      final messages = await sl<LoadMessagesUsecase>().call(item.id);
      final assistantMessages = messages
          .where((message) => message['isUser'] != true)
          .map((message) => message['text']?.toString() ?? '')
          .where((message) => message.isNotEmpty)
          .toList();
      final answer = assistantMessages.isNotEmpty
          ? assistantMessages.last
          : (messages.isNotEmpty
                ? messages.last['text']?.toString() ?? ''
                : item.lastMessage);

      if (context.mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CustomAiModelAnswerScreen(data: answer),
          ),
        );
      }
    }

    if (context.mounted) {
      await context.read<HistoryCubit>().loadHistory();
    }
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

    return BlocListener<NavigationCubit, int>(
      // The screen stays alive inside an IndexedStack, so initState() only
      // ever runs once. Without this, switching to the History tab after
      // creating a chat/README/review would keep showing stale data since
      // nothing ever tells HistoryCubit to reload. This re-fetches every
      // time the History tab becomes the active one.
      listenWhen: (previous, current) =>
          current == _historyTabIndex && previous != _historyTabIndex,
      listener: (context, index) {
        context.read<HistoryCubit>().loadHistory();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: local.history, needButton: false),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final isTablet = width >= 600;
            final isDesktop = width >= 1024;

            final horizontalPadding = isDesktop
                ? 40.0
                : (isTablet ? 28.0 : 16.0);
            final titleSize = isDesktop ? 28.0 : 24.0;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 900 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightSpace(height: 24),
                      Text(
                        local.activityHistory,
                        style: GoogleFonts.geist(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const HeightSpace(height: 16),
                      CustomHistoryTextField(controller: historyController),
                      const HeightSpace(height: 10),

                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: filterChips.length,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
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
                      const HeightSpace(height: 20),

                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () =>
                              context.read<HistoryCubit>().loadHistory(),
                          child: BlocBuilder<HistoryCubit, HistoryState>(
                            builder: (context, state) {
                              if (state is HistoryLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                );
                              }

                              if (state is HistoryLoaded) {
                                final filteredHistory = state.history.where((
                                  item,
                                ) {
                                  final matchesType =
                                      selectedFilterIndex == 0 ||
                                      item.type.toLowerCase() ==
                                          filterChips[selectedFilterIndex]
                                              .toLowerCase();

                                  final matchesQuery =
                                      searchQuery.isEmpty ||
                                      item.title.toLowerCase().contains(
                                        searchQuery,
                                      ) ||
                                      item.lastMessage.toLowerCase().contains(
                                        searchQuery,
                                      );

                                  return matchesType && matchesQuery;
                                }).toList();

                                if (filteredHistory.isEmpty) {
                                  return ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height: constraints.maxHeight * 0.6,
                                        child: Center(
                                          child: Text(
                                            'No history found',
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  itemCount: filteredHistory.length,
                                  itemBuilder: (context, index) {
                                    final item = filteredHistory[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: CustomHistoryCardWidget(
                                        title: item.title.isEmpty
                                            ? local.newChat
                                            : item.title,
                                        description: item.lastMessage.isEmpty
                                            ? local.noMessageYet
                                            : item.lastMessage,
                                        chipType: item.type,
                                        time: item.updatedAt,
                                        onTap: () =>
                                            _openHistoryItem(context, item),
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
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
