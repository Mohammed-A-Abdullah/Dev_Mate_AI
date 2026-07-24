import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomReviewInputDecorator extends StatelessWidget {
  const CustomReviewInputDecorator({super.key, this.onSelected, required this.reviewOptions, required this.selectedReviewOptions});
final void Function(bool)? onSelected;
final List<String>reviewOptions;
  final List<String> selectedReviewOptions;
  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
    return InputDecorator(
                decoration: InputDecoration(
                  fillColor: Color(0xff1E1F26),
                  filled: true,
                  labelText: local.language,
                  hintText: local.programmingLang,
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xff6F7385),
                    fontSize: 14.sp,
                  ),
                  labelStyle: TextStyle(color: Color(0xff6F7385)),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff434654)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff434654)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: reviewOptions.map((tech) {
                    final selected = selectedReviewOptions.contains(tech);

                    return FilterChip(
                      label: Text(tech),
                      selected: selected,
                      onSelected: onSelected
                    );
                  }).toList(),
                ),
              );
  }
}