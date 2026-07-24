import 'package:dev_mate_ai/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_entity.dart';

class OnboardingRepositoryImp  implements OnboardingRepository{
  @override
  List<OnboardingEntity> getOnboardingPages() {
    return  [
      OnboardingEntity(
        icon: Icons.auto_awesome_outlined,
        title: S.current.onboardingTitle1,
        description:
            S.current.onboardingDesc1,
      ),
      OnboardingEntity(
        icon: Icons.code_rounded,
        title: S.current.onboardingTitle2,
        description:
            S.current.onboardingDesc2,
      ),
      OnboardingEntity(
        icon: Icons.speed_rounded,
        title: S.current.onboardingTitle3,
        description:
            S.current.onboardingDesc3,
      ),
    ];
  }
}
