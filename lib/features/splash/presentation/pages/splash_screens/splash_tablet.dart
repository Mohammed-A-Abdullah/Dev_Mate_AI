import 'package:dev_mate_ai/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';

class SplashTablet extends StatelessWidget {
  const SplashTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashBody(
      logoSize: 140,
      titleSize: 55,
      descriptionSize: 22,
      progressWidth: 280,
      topSpace: 120,
      bottomSpace: 160,
    );
  }
}
