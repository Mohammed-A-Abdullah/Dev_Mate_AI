import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/responsive/responsive_layout.dart';
import 'package:dev_mate_ai/features/navigation_bar/navigation_pages.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NavigationCubit>(),

      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          final content = IndexedStack(
            index: state,

            children: NavigationPages.pages,
          );

          return ResponsiveLayout(
            mobile: _MobileNavigation(currentIndex: state, content: content),

            tablet: _TabletNavigation(currentIndex: state, content: content),

            desktop: _DesktopNavigation(currentIndex: state, content: content),
          );
        },
      ),
    );
  }
}
class _MobileNavigation extends StatelessWidget {
  const _MobileNavigation({required this.currentIndex, required this.content});

  final int currentIndex;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: content,

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (value) {
          context.read<NavigationCubit>().changeIndex(value);
        },
      ),
    );
  }
}
class _TabletNavigation extends StatelessWidget {
  const _TabletNavigation({required this.currentIndex, required this.content});

  final int currentIndex;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: content,

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (value) {
          context.read<NavigationCubit>().changeIndex(value);
        },
      ),
    );
  }
}
class _DesktopNavigation extends StatelessWidget {
  const _DesktopNavigation({required this.currentIndex, required this.content});

  final int currentIndex;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: Row(
        children: [
          NavigationRail(
            minWidth: 80,

            minExtendedWidth: 210,

            selectedIndex: currentIndex,

            onDestinationSelected: (value) {
              context.read<NavigationCubit>().changeIndex(value);
            },

            backgroundColor: theme.colorScheme.surface,

            selectedIconTheme: IconThemeData(
              color: theme.colorScheme.primary,

              size: 24,
            ),

            unselectedIconTheme: IconThemeData(
              color: theme.colorScheme.onSurface.withValues(alpha: .5),

              size: 24,
            ),

            selectedLabelTextStyle: TextStyle(
              color: theme.colorScheme.primary,

              fontWeight: FontWeight.w600,
            ),

            unselectedLabelTextStyle: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: .6),
            ),

            labelType: NavigationRailLabelType.all,

            groupAlignment: 0,

            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),

                selectedIcon: Icon(Icons.home),

                label: Text('Home'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.chat_bubble_outline),

                selectedIcon: Icon(Icons.chat_bubble),

                label: Text('Chat'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.history_outlined),

                selectedIcon: Icon(Icons.history),

                label: Text('History'),
              ),

              NavigationRailDestination(
                icon: Icon(Icons.person_outline),

                selectedIcon: Icon(Icons.person),

                label: Text('Profile'),
              ),
            ],
          ),

          VerticalDivider(
            width: 1,
            thickness: 1,
            color: theme.colorScheme.outline,
          ),

          Expanded(child: content),
        ],
      ),
    );
  }
}
