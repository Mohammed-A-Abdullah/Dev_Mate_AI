import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/code_review_cubit.dart';
import '../cubit/code_review_state.dart';

class CustomReveiwTypesChips extends StatelessWidget {
  const CustomReveiwTypesChips({super.key, required this.state});
  final CodeReviewState state;
  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final reviewOptions = const [
      'Bugs',
      'Security',
      'Clean Code',
      'Performance',
      'Code Quality',
      'Best Practices',
      'Memory Usage',
      'Maintainability',
      'Accessibility (UI)',
      'Readability',
      'Architecture',
      'Error Handling',
      'Documentation',
      'Testing Suggestions',
    ];
    return InputDecorator(
      decoration: InputDecoration(
        labelText: local.reviewFocus,
        hintText: local.reviewFocusDes,
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: reviewOptions.map((tech) {
          final selected = state.reviewTypes.contains(tech);
          return FilterChip(
            showCheckmark: false,
            backgroundColor: Theme.of(context).colorScheme.outline,
            selectedColor: Theme.of(context).colorScheme.secondary,
            label: Text(
              tech,
              style: GoogleFonts.inter(
                color: selected
                    ? Theme.of(context).colorScheme.outline
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
            selected: selected,
            onSelected: (_) {
              context.read<CodeReviewCubit>().toggleReviewType(tech);
            },
          );
        }).toList(),
      ),
    );
  }
}
