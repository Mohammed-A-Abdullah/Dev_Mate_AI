import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLinearProgressWidget extends StatelessWidget {
  const CustomLinearProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 192.w,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 5),
        curve: Curves.slowMiddle,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            minHeight: 3.h,
            borderRadius: BorderRadius.circular(50.r),
            backgroundColor: Colors.blueGrey.withValues(alpha: 0.3),
            color: Color(0xffCDBDFF),
            value: value,
          );
        },
      ),
    );
  }
}
