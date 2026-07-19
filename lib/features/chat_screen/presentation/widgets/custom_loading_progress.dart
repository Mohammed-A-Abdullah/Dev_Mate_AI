import 'package:flutter/material.dart';

class CustomLoadingProgress extends StatelessWidget {
  const CustomLoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: LinearProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
