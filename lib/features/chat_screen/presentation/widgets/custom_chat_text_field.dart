import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomChatTextField extends StatelessWidget {
  const CustomChatTextField({
    super.key,
    required this.chatController,
    this.onPressed,
  });
  final TextEditingController chatController;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CustomTextField(
      controller: chatController,
      hintText: local.chatHintText,
      radius: 20,
      keyBoardType: TextInputType.multiline,
      prefixIcon: Icon(
        Icons.smart_toy_sharp,
        color: Theme.of(context).colorScheme.primary,
        size: 24,
      ),
      suffixIconWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          margin: const EdgeInsets.all(4),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
