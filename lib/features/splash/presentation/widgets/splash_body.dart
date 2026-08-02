import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_linear_progress_widget.dart';
import 'package:dev_mate_ai/features/splash/presentation/widgets/custom_title_description.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'custom_logo_with_shadow_widget.dart';

class SplashBody extends StatelessWidget {
  final double logoSize;
  final double titleSize;
  final double descriptionSize;
  final double progressWidth;
  final double topSpace;
  final double bottomSpace;

  const SplashBody({
    super.key,
    required this.logoSize,
    required this.titleSize,
    required this.descriptionSize,
    required this.progressWidth,
    required this.topSpace,
    required this.bottomSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.background,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withValues(alpha: .3),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: topSpace),

                      CustomLogoWithShadowWidget(size: logoSize),

                      const SizedBox(height: 32),

                      CustomTitleDescription(
                        titleSize: titleSize,
                        descriptionSize: descriptionSize,
                      ),

                      SizedBox(height: bottomSpace),

                      CustomLinearProgressWidget(width: progressWidth),

                      const SizedBox(height: 24),

                      Text(S.of(context).POWERED_BY_ADVANCED_LLMS),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
