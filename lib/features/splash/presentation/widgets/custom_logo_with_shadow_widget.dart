import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_assets.dart';

class CustomLogoWithShadowWidget extends StatelessWidget {
  const CustomLogoWithShadowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 15.r,
            spreadRadius: 10.r,
          ),
        ],
      ),
      child: SvgPicture.asset(AppAssets.logo, width: 96.w),
    );
  }
}
