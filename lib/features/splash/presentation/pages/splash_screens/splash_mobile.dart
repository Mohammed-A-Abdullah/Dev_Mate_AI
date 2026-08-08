import 'package:dev_mate_ai/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';

class SplashMobile extends StatelessWidget {
  const SplashMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashBody(
      logoSize: 96,
      titleSize: 40,
      descriptionSize: 16,
      progressWidth: 190,
      topSpace: 140,
      bottomSpace: 120,
    );
  }
}
