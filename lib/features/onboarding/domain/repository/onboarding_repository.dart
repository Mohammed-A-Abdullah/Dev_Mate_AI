import 'package:dev_mate_ai/features/onboarding/domain/entities/onboarding_entity.dart';

abstract class OnboardingRepository {
  List<OnboardingEntity>getOnboardingPages();
}