import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return CustomTextField(
      controller: chatController,
      hintText: "Message DevMate AI...",
      radius: 20.r,
      keyBoardType: TextInputType.multiline,
      prefixIcon: Icon(
        Icons.attach_file,
        color: Theme.of(context).colorScheme.outline,
        size: 24.sp,
      ),
      suffixIconWidget: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: Container(
          margin: const EdgeInsets.all(4),
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(14.r),
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
