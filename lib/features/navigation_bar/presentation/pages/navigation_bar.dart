import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/features/navigation_bar/navigation_pages.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/cubit/navigation_bar_cubit.dart';
import 'package:dev_mate_ai/features/navigation_bar/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NavigationCubit>(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            body: NavigationPages.pages[state],

            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: state,
              onTap: (value) =>
                  context.read<NavigationCubit>().changeIndex(value),
            )
          );
        },
      ),
    );
  }
}