import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/theme/extensions/auth_theme_extension.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final VoidCallback onTap;


  factory SocialLoginButton.google({required VoidCallback onTap}) {
    return SocialLoginButton(
      title: "Continue with Google",
      onTap: onTap,
      icon: SvgPicture.asset(AppAssets.google, width: 24.w),
    );
  }

  factory SocialLoginButton.github({required VoidCallback onTap}) {
    return SocialLoginButton(
      title: "Continue with GitHub",
      onTap: onTap,
      icon: SvgPicture.asset(AppAssets.gitHub, width: 24.w),
    );
  }

  factory SocialLoginButton.guest({required VoidCallback onTap}) {
    return SocialLoginButton(
      title: "Continue as Guest",
      onTap: onTap,
      icon: const Icon(Icons.person_outline, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Ink(
          height: 58.h,
          decoration: BoxDecoration(
            color: Theme.of(context).extension<AuthThemeExtension>()!.socialBackground,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Row(
            children: [
              WidthSpace(width: 18.w),

              SizedBox(
                width: 26.w,
                child: Center(child: icon),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 44.w),
            ],
          ),
        ),
      ),
    );
  }
}
