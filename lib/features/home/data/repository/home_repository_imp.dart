import 'package:dev_mate_ai/features/home/domain/entities/home_quick_tool_entity.dart';
import 'package:dev_mate_ai/features/home/domain/repository/home_quick_tools_repository.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImp implements HomeQuickToolsRepository {
  @override
  List<HomeQuickToolEntity> getHomeQuickTools() {
    return [
      HomeQuickToolEntity(
        icon: Icons.menu_book_outlined,
        iconColor: Color(0xffB5C4FF),
        title: "Explain Code",
        description: "Break down complex logic",
      ),
      HomeQuickToolEntity(
        icon: Icons.build_outlined,
        iconColor: Color(0xffFFB4AB),
        title: "Debug Code",
        description: "Find and fix errors fast",
      ),
      HomeQuickToolEntity(
        icon: Icons.description_outlined,
        iconColor: Color(0xffCDBDFF),
        title: "Generate README",
        description: "Instant documentation",
      ),
      HomeQuickToolEntity(
        icon: Icons.account_tree_outlined,
        iconColor: Color(0xff3CDDC7),
        title: "Project Planner",
        description: "Architect your next app",
      ),
      HomeQuickToolEntity(
        icon: Icons.chat_bubble_outline,
        iconColor: Color(0xffDCE1FF),
        title: "AI Chat",
        description: "Open-ended coding help",
      ),
      HomeQuickToolEntity(
        icon: Icons.fact_check_outlined,
        iconColor: Color(0xffE8DEFF),
        title: "Code Review",
        description: "Analyze for best practices",
      ),
    ];
  }
}
