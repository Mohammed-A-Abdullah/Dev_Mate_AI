import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/responsive/responsive_layout.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
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

    Widget buildRailItem({
      required IconData icon,
      required String label,
      required bool isSelected,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Row(
        children: [
          NavigationRail(
            minWidth: 140,
            selectedIndex: currentIndex,
            onDestinationSelected: (value) {
              context.read<NavigationCubit>().changeIndex(value);
            },
            backgroundColor: theme.scaffoldBackgroundColor,
            useIndicator: false,

            labelType: NavigationRailLabelType.selected,

            selectedIconTheme: IconThemeData(
              color: theme.colorScheme.primary,
              size: 24,
            ),
            unselectedIconTheme: IconThemeData(
              color: theme.colorScheme.onSurface.withValues(alpha: .5),
              size: 24,
            ),
            groupAlignment: -0.8,
            destinations: [
              NavigationRailDestination(
                icon: buildRailItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  isSelected: false,
                ),
                selectedIcon: buildRailItem(
                  icon: Icons.home,
                  label: 'Home',
                  isSelected: true,
                ),
                label: const SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: buildRailItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  isSelected: false,
                ),
                selectedIcon: buildRailItem(
                  icon: Icons.chat_bubble,
                  label: 'Chat',
                  isSelected: true,
                ),
                label: const SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: buildRailItem(
                  icon: Icons.history_outlined,
                  label: 'History',
                  isSelected: false,
                ),
                selectedIcon: buildRailItem(
                  icon: Icons.history,
                  label: 'History',
                  isSelected: true,
                ),
                label: const SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: buildRailItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  isSelected: false,
                ),
                selectedIcon: buildRailItem(
                  icon: Icons.person,
                  label: 'Profile',
                  isSelected: true,
                ),
                label: const SizedBox.shrink(),
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
