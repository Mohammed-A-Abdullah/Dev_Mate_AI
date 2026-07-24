import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomHistoryTextField extends StatelessWidget {
  const CustomHistoryTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    
    return CustomTextField(
      controller: controller,
      hintText: S.of(context).searchHistory,

      prefixIcon: Icon(Icons.search, size: 20.sp),
      radius: 50.r,
    );
  }
}
