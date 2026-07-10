import 'package:flutter/material.dart';

class CustomLoadingProgress extends StatelessWidget {
  const CustomLoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    color: Color(0xffB5C4FF),
                    backgroundColor: Colors.transparent,
                  ),
                );
  }
}