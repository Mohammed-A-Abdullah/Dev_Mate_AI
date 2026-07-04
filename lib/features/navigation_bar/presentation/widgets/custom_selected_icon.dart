import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectedIcon extends StatelessWidget {
  const CustomSelectedIcon({super.key, required this.iconData});
final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 28.sp),
        const SizedBox(height: 4),
        Container(
          width: 5.w,
          height: 5.h,
          decoration: const BoxDecoration(
            color: Color(0xffB5C4FF),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}