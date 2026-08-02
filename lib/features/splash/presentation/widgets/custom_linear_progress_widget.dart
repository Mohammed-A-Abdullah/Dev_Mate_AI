import 'package:flutter/material.dart';

class CustomLinearProgressWidget extends StatelessWidget {
  final double width;

  const CustomLinearProgressWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(seconds: 5),
        builder: (_, value, __) {
          return LinearProgressIndicator(
            value: value,
            minHeight: 4,
            borderRadius: BorderRadius.circular(100),
          );
        },
      ),
    );
  }
}
