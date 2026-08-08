import 'package:dev_mate_ai/core/constants/app_assets.dart';
import 'package:dev_mate_ai/core/theme/extensions/auth_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isLoading = false,
  });

  final String title;
  final Widget icon;
  final VoidCallback onTap;
  final bool isLoading;

  factory SocialLoginButton.google({
    required VoidCallback onTap,
    required bool isLoading,
  }) {
    return SocialLoginButton(
      title: 'Continue with Google',
      icon: SvgPicture.asset(AppAssets.google, width: 22, height: 22),
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  factory SocialLoginButton.github({
    required VoidCallback onTap,
    required bool isLoading,
  }) {
    return SocialLoginButton(
      title: 'Continue with GitHub',
      icon: SvgPicture.asset(AppAssets.gitHub, width: 22, height: 22),
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  factory SocialLoginButton.guest({
    required VoidCallback onTap,
    required bool isLoading,
  }) {
    return SocialLoginButton(
      title: 'Continue as Guest',
      icon: const Icon(Icons.person_outline, size: 22),
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: isLoading ? null : onTap,

        borderRadius: BorderRadius.circular(16),

        child: Ink(
          width: double.infinity,

          height: 56,

          decoration: BoxDecoration(
            color: theme.extension<AuthThemeExtension>()!.socialBackground,

            borderRadius: BorderRadius.circular(16),

            border: Border.all(color: theme.colorScheme.outline),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),

            child: Stack(
              alignment: Alignment.center,

              children: [
                /// Icon
                Align(
                  alignment: AlignmentDirectional.centerStart,

                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(child: icon),
                  ),
                ),

                /// Text / Loading
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),

                  child: isLoading
                      ? SizedBox(
                          key: const ValueKey('loading'),

                          width: 20,
                          height: 20,

                          child: CircularProgressIndicator(
                            strokeWidth: 2,

                            color: theme.colorScheme.primary,
                          ),
                        )
                      : Text(
                          key: const ValueKey('text'),

                          title,

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: theme.colorScheme.secondary,

                            fontWeight: FontWeight.w600,

                            fontSize: 14,

                            letterSpacing: .1,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
