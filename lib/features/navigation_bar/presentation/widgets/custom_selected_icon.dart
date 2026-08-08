import 'package:flutter/material.dart';

class CustomSelectedIcon extends StatelessWidget {
  const CustomSelectedIcon({super.key, required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        Icon(iconData, size: 26, color: theme.colorScheme.primary),

        const SizedBox(height: 4),

        Container(
          width: 5,
          height: 5,

          decoration: BoxDecoration(
            color: theme.colorScheme.primary,

            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
