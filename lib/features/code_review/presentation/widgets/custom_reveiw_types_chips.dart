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
        fillColor: const Color(0xff1E1F26),
        filled: true,
        labelText: 'Review Focus',
        hintText: 'Select focus areas',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xff6F7385),
          fontSize: 14.sp,
        ),
        labelStyle: TextStyle(color: const Color(0xff6F7385)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff434654)),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff434654)),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(16),
        ),
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