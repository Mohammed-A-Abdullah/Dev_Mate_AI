import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/widgets/spacing_widgets.dart';

class CustomHistoryCardWidget extends StatelessWidget {
  const CustomHistoryCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.chipType,
    required this.time,
    this.onTap,
  });
  final String title;
  final String description;
  final String chipType;
  final DateTime time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff1A1D26),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffE2E2EB),
                ),
              ),
              HeightSpace(height: 8),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Color(0xffC3C5D7),
                  fontWeight: FontWeight.w400,
                ),
              ),
              HeightSpace(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      chipType,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12.sp,
                        color: const Color(0xff8d90a0),
                      ),
                    ),
                    backgroundColor: const Color(0xff0C0E14),
                    side: BorderSide(color: Colors.transparent),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                  ),
                  Text(
                    timeago.format(time),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Color(0xff8d90a0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
