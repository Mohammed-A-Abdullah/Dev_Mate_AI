import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_markdown_body.dart';

class CustomUserAndBotMessage extends StatelessWidget {
  const CustomUserAndBotMessage({super.key, required this.check, required this.text, this.onTap});
final bool check;
final String text;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: check ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap:onTap ,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(14),
          constraints: BoxConstraints(
            maxWidth: check
                ? MediaQuery.of(context).size.width * .75
                : MediaQuery.of(context).size.width * .90,
          ),
          decoration: BoxDecoration(
            color: check
                ? const Color(0xffB5C4FF)
                : const Color(0xff1D1E25),
            borderRadius: BorderRadius.circular(18),
            border: check
                ? null
                : Border.all(color: const Color(0xff2A2D3A)),
          ),
          child: check
              ? Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                )
              : CustomMarkdownBody(inputData: text),
        ),
      ),
    );
  }
}