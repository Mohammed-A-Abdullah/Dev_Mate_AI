import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dev_mate_ai/features/history/presentation/cubit/history_cubit.dart';
import 'package:dev_mate_ai/features/history/presentation/cubit/history_state.dart';
import 'package:dev_mate_ai/features/history/presentation/widgets/custom_history_card_widget.dart';
import 'package:dev_mate_ai/features/home/presentation/cubit/home_cubit.dart';
import 'package:dev_mate_ai/features/home/presentation/cubit/home_state.dart';
import 'package:dev_mate_ai/features/home/presentation/helper/home_helper.dart';
import 'package:dev_mate_ai/features/home/presentation/widgets/custom_new_chat_container.dart';
import 'package:dev_mate_ai/features/home/presentation/widgets/quick_tool_item.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../chat_screen/presentation/pages/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;
  late final AuthCubit _authCubit;
  late final HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = sl<HomeCubit>()..loadHomeData();
    _authCubit = sl<AuthCubit>()..checkAuthStatus();
    _historyCubit = sl<HistoryCubit>()..loadHistory();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _authCubit.close();
    _historyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final local = S.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(value: _homeCubit),
        BlocProvider<AuthCubit>.value(value: _authCubit),
        BlocProvider<HistoryCubit>.value(value: _historyCubit),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: local.appName, needButton: false),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }

            if (state is HomeLoaded) {
              return SafeArea(
                bottom: true,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;

                    final isTablet = width >= 600;
                    final isDesktop = width >= 1024;

                    final horizontalPadding = isDesktop
                        ? 40.0
                        : (isTablet ? 28.0 : 16.0);

                    final greetingSize = isDesktop ? 28.0 : 24.0;
                    final sectionTitleSize = isDesktop ? 22.0 : 20.0;

                    return SingleChildScrollView(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isDesktop ? 1000 : double.infinity,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HeightSpace(height: 24),

                                Text(
                                  '${HomeHelper.getGreeting(local)}${HomeHelper.getFormattedName(currentUser?.displayName ?? "User", local.user)} ',
                                  style: GoogleFonts.geist(
                                    fontSize: greetingSize,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                Text(
                                  local.homeReadyToBuild,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                const HeightSpace(height: 32),
                                const CustomNewChatContainer(),
                                const HeightSpace(height: 32),

                                Text(
                                  local.homeQuickTool,
                                  style: GoogleFonts.inter(
                                    fontSize: sectionTitleSize,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),

                                const HeightSpace(height: 16),

                                LayoutBuilder(
                                  builder: (context, gridConstraints) {
                                    final gridWidth = gridConstraints.maxWidth;

                                    int crossAxisCount;

                                    if (gridWidth < 600) {
                                      crossAxisCount = 2;
                                    } else if (gridWidth < 1024) {
                                      crossAxisCount = 3;
                                    } else {
                                      crossAxisCount = 4;
                                    }

                                    return GridView.builder(
                                      shrinkWrap: true,

                                      physics:
                                          const NeverScrollableScrollPhysics(),

                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,

                                            crossAxisSpacing: 16,

                                            mainAxisSpacing: 16,

                                            childAspectRatio: gridWidth >= 1024
                                                ? 1.25
                                                : 1.15,
                                          ),

                                      itemCount: state.quickTools.length,

                                      itemBuilder: (context, index) {
                                        return QuickToolItem(
                                          tool: state.quickTools[index],
                                        );
                                      },
                                    );
                                  },
                                ),

                                const HeightSpace(height: 32),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      local.homeRecentActivity,
                                      style: GoogleFonts.inter(
                                        fontSize: sectionTitleSize,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<NavigationCubit>()
                                            .changeIndex(2);
                                      },
                                      child: Text(
                                        local.homeViewAll,
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          letterSpacing: 0.55,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const HeightSpace(height: 22),

                                BlocBuilder<HistoryCubit, HistoryState>(
                                  builder: (context, historyState) {
                                    if (historyState is HistoryLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      );
                                    }

                                    if (historyState is HistoryLoaded) {
                                      if (historyState.history.isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Center(
                                            child: Text(
                                              local.noElements,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                    .withValues(alpha: 0.5),
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      final items =
                                          historyState.history.length > 3
                                          ? historyState.history
                                                .take(3)
                                                .toList()
                                          : historyState.history;

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          final item = items[index];

                                          return CustomHistoryCardWidget(
                                            title: item.title.isEmpty
                                                ? local.newChat
                                                : item.title,
                                            description:
                                                item.lastMessage.isEmpty
                                                ? local.noMessageYet
                                                : item.lastMessage,
                                            chipType: item.type,
                                            time: item.updatedAt,
                                            onTap: () {
                                              if (item.type.toLowerCase() ==
                                                  local.chats) {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) => ChatScreen(
                                                      chatId: item.id,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                // Handle other types here
                                              }
                                            },
                                          );
                                        },
                                      );
                                    }

                                    if (historyState is HistoryError) {
                                      return Center(
                                        child: Text(
                                          historyState.message,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                          ),
                                        ),
                                      );
                                    }

                                    return const SizedBox.shrink();
                                  },
                                ),

                                const HeightSpace(height: 40),
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

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
