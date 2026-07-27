import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dev_mate_ai/core/theme/extensions/dropdown_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownbuttonfield extends StatefulWidget {
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
  State<CustomDropdownbuttonfield> createState() =>
      _CustomDropdownbuttonfieldState();
}

class _CustomDropdownbuttonfieldState extends State<CustomDropdownbuttonfield> {
  late final ValueNotifier<String?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<String?>(widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownbuttonfield oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _valueNotifier.value) {
      _valueNotifier.value = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownTheme = Theme.of(context).extension<DropdownThemeExtension>();

    final effectiveColor =
        dropdownTheme?.dropdownColor ?? Theme.of(context).cardColor;

    return CustomDropdown<String>(
      hintText: widget.hintText,
      items: widget.items,
      initialItem: widget.initialValue,
      onChanged: widget.onChanged,

      animation: const CustomDropdownAnimation(
        type: DropdownAnimationType.sizeFade,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      ),

      decoration: CustomDropdownDecoration(
        closedFillColor: effectiveColor,
        expandedFillColor: effectiveColor,

        closedBorderRadius: BorderRadius.circular(12.r),
        expandedBorderRadius: BorderRadius.circular(12.r),
        closedBorder: BoxBorder.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1.5,
        ),
        expandedBorder: BoxBorder.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        hintStyle: GoogleFonts.inter(
          color: Theme.of(context).hintColor,
          fontSize: 14.sp,
        ),
        headerStyle: GoogleFonts.inter(
          color: dropdownTheme?.textDropdown,
          fontSize: 16.sp,
        ),
        listItemStyle: GoogleFonts.inter(
          color: dropdownTheme?.textDropdown,
          fontSize: 16.sp,
        ),
        prefixIcon: const Icon(Icons.code),
      ),
    );
  }
}
