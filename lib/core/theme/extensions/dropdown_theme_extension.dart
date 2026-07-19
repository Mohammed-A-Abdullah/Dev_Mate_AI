import 'package:flutter/material.dart';

class DropdownThemeExtension extends ThemeExtension<DropdownThemeExtension> {
  final Color dropdownColor;
  final Color textDropdown;

  DropdownThemeExtension({required this.dropdownColor, required this.textDropdown});
  @override
  ThemeExtension<DropdownThemeExtension> copyWith({Color? dropdownColor ,Color? textDropdown,}) {
    return DropdownThemeExtension(dropdownColor: dropdownColor ?? this.dropdownColor, 
    textDropdown: textDropdown ?? this.textDropdown);
  }

  @override
  ThemeExtension<DropdownThemeExtension> lerp(
    covariant DropdownThemeExtension? other,
    double t,
  ) {
    if (other is! DropdownThemeExtension) {
      return this;
    }
    return DropdownThemeExtension(
      dropdownColor: Color.lerp(dropdownColor, other.dropdownColor, t)!,
       textDropdown: Color.lerp(textDropdown, other.dropdownColor, t)!,
    );
  }
}
