import 'package:dev_mate_ai/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_entity.dart';

class OnboardingRepositoryImp  implements OnboardingRepository{
  @override
  List<OnboardingEntity> getOnboardingPages() {
    return const [
      OnboardingEntity(
        icon: Icons.auto_awesome_outlined,
        title: "AI Coding Assistant",
        description:
            "Your 24/7 pair programmer. Get help with code completion, refactoring, and logical breakthroughs.",
      ),
      OnboardingEntity(
        icon: Icons.code_rounded,
        title: "Refactor Instantly",
        description:
            "Clean your architecture and optimize functions with a single click inside your editor.",
      ),
      OnboardingEntity(
        icon: Icons.speed_rounded,
        title: "Boost Productivity",
        description:
            "Ship features faster without losing quality. Your personalized AI companion is ready.",
      ),
    ];
  }
}
