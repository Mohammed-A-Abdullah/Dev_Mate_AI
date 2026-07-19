import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/code_review_cubit.dart';
import '../cubit/code_review_state.dart';

class CustomReveiwTypesChips extends StatelessWidget {
  const CustomReveiwTypesChips({super.key, required this.state});
final CodeReviewState state;
  @override
  Widget build(BuildContext context) {
    final reviewOptions = const [
      'Code Quality',
      'Performance',
      'Security',
      'Bugs',
      'Best Practices',
      'Clean Code',
      'Readability',
      'Maintainability',
      'Architecture',
      'Memory Usage',
      'Error Handling',
      'Testing Suggestions',
      'Documentation',
      'Accessibility (UI)',
    ];
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Review Focus',
        hintText: 'Select focus areas',
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: reviewOptions.map((tech) {
          final selected = state.reviewTypes.contains(tech);
          return FilterChip(
            label: Text(tech),
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