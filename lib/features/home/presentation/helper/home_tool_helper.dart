import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/features/home/domain/entities/home_tool_type.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeToolHelper {
  static IconData icon(HomeToolType type) {
    switch (type) {
      case HomeToolType.explainCode:
        return Icons.menu_book_outlined;

      case HomeToolType.debugCode:
        return Icons.build_outlined;

      case HomeToolType.generateReadme:
        return Icons.description_outlined;

      case HomeToolType.projectPlanner:
        return Icons.account_tree_outlined;

      case HomeToolType.aiChat:
        return Icons.chat_bubble_outline;

      case HomeToolType.codeReview:
        return Icons.fact_check_outlined;
    }
  }

  static Color color(HomeToolType type) {
    switch (type) {
      case HomeToolType.explainCode:
        return const Color(0xffB5C4FF);

      case HomeToolType.debugCode:
        return const Color(0xffFFB4AB);

      case HomeToolType.generateReadme:
        return const Color(0xffCDBDFF);

      case HomeToolType.projectPlanner:
        return const Color(0xff3CDDC7);

      case HomeToolType.aiChat:
        return const Color(0xffDCE1FF);

      case HomeToolType.codeReview:
        return const Color(0xffE8DEFF);
    }
  }

  static String route(HomeToolType type) {
    switch (type) {
      case HomeToolType.explainCode:
        return RouteName.explainCodeScreen;

      case HomeToolType.debugCode:
        return RouteName.debugCodeScreen;

      case HomeToolType.generateReadme:
        return RouteName.generateReadmeScreen;

      case HomeToolType.projectPlanner:
        return RouteName.projectPlannerScreen;

      case HomeToolType.aiChat:
        return RouteName.chatScreen;

      case HomeToolType.codeReview:
        return RouteName.codeReviewScreen;
    }
  }

  static String title(HomeToolType type, S local) {
    switch (type) {
      case HomeToolType.explainCode:
        return local.explainCodeTitle;
      case HomeToolType.debugCode:
        return local.debugCodeTitle;
      case HomeToolType.generateReadme:
        return local.generateReadmeTitle;
      case HomeToolType.projectPlanner:
        return local.projectPlannerTitle;
      case HomeToolType.aiChat:
        return local.aiChatTitle;
      case HomeToolType.codeReview:
        return local.codeReviewTitle;
    }
  }

  static String description(HomeToolType type, S local) {
    switch (type) {
      case HomeToolType.explainCode:
        return local.explainCodeDesc;
      case HomeToolType.debugCode:
        return local.debugCodeDesc;
      case HomeToolType.generateReadme:
        return local.generateReadmeDesc;
      case HomeToolType.projectPlanner:
        return local.projectPlannerDesc;
      case HomeToolType.aiChat:
        return local.aiChatDesc;
      case HomeToolType.codeReview:
        return local.codeReviewDesc;
    }
  }
}
