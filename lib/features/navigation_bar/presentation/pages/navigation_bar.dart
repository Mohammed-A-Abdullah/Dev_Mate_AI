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
      create: (context) => sl<NavigationCubit>(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          final content = IndexedStack(
            index: state,
            children: NavigationPages.pages,
          );

          return ResponsiveLayout(
            mobile: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: content,
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: state,
                onTap: (value) =>
                    context.read<NavigationCubit>().changeIndex(value),
              ),
            ),

            desktop: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: state,
                    onDestinationSelected: (value) =>
                        context.read<NavigationCubit>().changeIndex(value),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    selectedIconTheme: IconThemeData(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    unselectedIconTheme: IconThemeData(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    labelType: NavigationRailLabelType.all,
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
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: Text('Profile'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),

                  Expanded(child: content),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
