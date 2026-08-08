import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomLogoWithShadowWidget extends StatelessWidget {
  final double size;

  const CustomLogoWithShadowWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: .1),
            blurRadius: size * .15,
            spreadRadius: size * .08,
          ),
        ],
      ),
      child: SvgPicture.asset(AppAssets.logo, width: size),
    );
  }
}
