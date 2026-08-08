import 'package:dev_mate_ai/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,

      child: TextButton(
        onPressed: () async {
          await context.read<OnboardingCubit>().finishOnboarding();
        },

        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        child: Text(
          S.of(context).skip,

          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,

            fontWeight: FontWeight.w500,

            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
