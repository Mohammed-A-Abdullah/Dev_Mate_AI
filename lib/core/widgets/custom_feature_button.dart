import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFeatureButton extends StatelessWidget {
  const CustomFeatureButton({
    super.key,
    this.onTap,
    required this.text,
    required this.isLoading,
  });
  final void Function()? onTap;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        width: double.infinity,
        height: 55.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.55.sp,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
      ),
    );
  }
}
