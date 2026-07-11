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
      decoration: InputDecoration(
        fillColor: Color(0xff1E1F26),
        filled: true,
        labelText: labelText,
        hintText: hintText,
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
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(16),
        ),
        prefixIcon: const Icon(Icons.code, color: Color(0xffC3C5D7)),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xffC3C5D7),
      ),
      borderRadius: BorderRadius.circular(16),
      itemHeight: 48.0,
      isDense: true,
      dropdownColor: Color(0xff1E1F26),
      elevation: 2,

      style: GoogleFonts.inter(color: Colors.white),
      initialValue: initialValue,

      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
