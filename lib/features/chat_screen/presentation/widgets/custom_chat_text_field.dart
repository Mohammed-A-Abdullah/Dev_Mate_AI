import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CustomChatTextField extends StatelessWidget {
  const CustomChatTextField({super.key, required this.chatController, this.onPressed});
  final TextEditingController chatController;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return  CustomTextField(
                controller: chatController,
                hintText: "Message DevMate AI...",
                fillColor: const Color(0xff1D1E25),
                borderColor: const Color(0xff2A2D3A),
                cursorColor: const Color(0xffB5C4FF),
                radius: 20.r,
                keyBoardType: TextInputType.multiline,
                textStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
                hintTextStyle: TextStyle(
                  color: const Color(0xff686B75),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.attach_file,
                  color: const Color(0xffC4C6D0),
                  size: 24.sp,
                ),
                suffixIconWidget: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffB5C4FF),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.send, color: Color(0xff001A4B)),
                    ),
                  ),
                ),
              );
  }
}