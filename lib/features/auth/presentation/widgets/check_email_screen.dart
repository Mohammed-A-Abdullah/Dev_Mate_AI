import 'package:dev_mate_ai/core/responsive/responsive_layout.dart';
import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: ResponsiveLayout(
          mobile: _CheckEmailContent(
            email: email,
            maxWidth: double.infinity,
            horizontalPadding: 24,
            iconSize: 45,
            titleSize: 24,
            descriptionSize: 13,
            buttonHeight: 50,
            isDesktop: false,
          ),

          tablet: _CheckEmailContent(
            email: email,
            maxWidth: 520,
            horizontalPadding: 32,
            iconSize: 55,
            titleSize: 30,
            descriptionSize: 15,
            buttonHeight: 52,
            isDesktop: false,
          ),

          desktop: _CheckEmailContent(
            email: email,
            maxWidth: 550,
            horizontalPadding: 40,
            iconSize: 65,
            titleSize: 36,
            descriptionSize: 16,
            buttonHeight: 54,
            isDesktop: true,
          ),
        ),
      ),
    );
  }
}
class _CheckEmailContent extends StatelessWidget {
  const _CheckEmailContent({
    required this.email,
    required this.maxWidth,
    required this.horizontalPadding,
    required this.iconSize,
    required this.titleSize,
    required this.descriptionSize,
    required this.buttonHeight,
    required this.isDesktop,
  });

  final String email;

  final double maxWidth;
  final double horizontalPadding;

  final double iconSize;
  final double titleSize;
  final double descriptionSize;

  final double buttonHeight;

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 30,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              _EmailIcon(iconSize: iconSize),

              SizedBox(height: isDesktop ? 35 : 30),

              Text(
                local.checkYourEmail,

                textAlign: TextAlign.center,

                style: GoogleFonts.jetBrainsMono(
                  fontSize: titleSize,

                  fontWeight: FontWeight.bold,

                  color: theme.colorScheme.onSecondary,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                local.checkYourEmailText,

                textAlign: TextAlign.center,

                style: GoogleFonts.jetBrainsMono(
                  fontSize: descriptionSize,

                  height: 1.6,

                  color: theme.colorScheme.secondary,
                ),
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: .08),

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: .15),
                  ),
                ),

                child: Text(
                  email,

                  textAlign: TextAlign.center,

                  style: GoogleFonts.jetBrainsMono(
                    fontSize: isDesktop ? 15 : 14,

                    fontWeight: FontWeight.w600,

                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                local.checkYourEmailOpenBox,

                textAlign: TextAlign.center,

                style: GoogleFonts.jetBrainsMono(
                  fontSize: descriptionSize,

                  height: 1.6,

                  color: theme.colorScheme.onSecondary,
                ),
              ),

              SizedBox(height: isDesktop ? 40 : 30),

              SizedBox(
                width: double.infinity,
                height: buttonHeight,

                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed(RouteName.authScreen);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,

                    foregroundColor: theme.colorScheme.onPrimary,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  child: Text(
                    local.backToSignIn,

                    style: GoogleFonts.jetBrainsMono(
                      fontWeight: FontWeight.w600,

                      fontSize: isDesktop ? 13 : 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: Text(
                  local.dontRevieveEmail,

                  textAlign: TextAlign.center,

                  style: GoogleFonts.jetBrainsMono(
                    fontSize: isDesktop ? 13 : 12,

                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _EmailIcon extends StatelessWidget {
  const _EmailIcon({required this.iconSize});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: iconSize * 2,
      height: iconSize * 2,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: theme.colorScheme.primary.withValues(alpha: .10),

        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: .20),

          width: 1.5,
        ),
      ),

      child: Icon(
        Icons.mark_email_read_outlined,

        size: iconSize,

        color: theme.colorScheme.primary,
      ),
    );
  }
}
