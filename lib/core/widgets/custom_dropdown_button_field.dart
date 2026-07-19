import 'package:dev_mate_ai/core/theme/extensions/dropdown_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownbuttonfield extends StatelessWidget {
  const CustomDropdownbuttonfield({
    super.key,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    required this.items,
    this.onChanged,
  });
  final String labelText;
  final String hintText;
  final String? initialValue;
  final List<String> items;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: 250.h,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,

        prefixIcon: const Icon(Icons.code),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      itemHeight: 48.0,
      isDense: true,
      dropdownColor: Theme.of(
        context,
      ).extension<DropdownThemeExtension>()!.dropdownColor,
      elevation: 2,

      style: GoogleFonts.inter(
        color: Theme.of(
          context,
        ).extension<DropdownThemeExtension>()!.textDropdown,
      ),
      initialValue: initialValue,

      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).extension<DropdownThemeExtension>()!.textDropdown,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
