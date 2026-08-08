import 'package:dev_mate_ai/features/splash/presentation/widgets/splash_body.dart';
import 'package:flutter/material.dart';

class SplashDesktop extends StatelessWidget {
  const SplashDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashBody(
      logoSize: 180,
      titleSize: 72,
      descriptionSize: 26,
      progressWidth: 350,
      topSpace: 60,
      bottomSpace: 180,
    );
  }
}
