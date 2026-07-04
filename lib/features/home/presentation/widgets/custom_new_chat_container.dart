import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNewChatContainer extends StatelessWidget {
  const CustomNewChatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    // 1. Base dark background color
                    color: const Color(0xff171923),

                    // 2. Rounded corners matching the image
                    borderRadius: BorderRadius.circular(28.r),

                    // 3. The thin, subtle border around the card
                    border: Border.all(
                      color: const Color(0xff2A2D3A),
                      width: 1.w,
                    ),

                    // 4. The smooth ambient gradient blending into the bottom-right corner
                    gradient: const RadialGradient(
                      center: Alignment(
                        0.7,
                        0.9,
                      ), // Positioned toward the bottom right
                      radius: 1.2,
                      colors: [
                        Color(0xff221C38), // Faint purple glow in the corner
                        Color(
                          0xff171923,
                        ), // Blends back into the main background color
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'What can I help you build today?',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffE2E2EB),
                        ),
                      ),
                      HeightSpace(height: 16),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 36.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                            color: Color(0xffB5C4FF),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 16.sp,
                                color: Color(0xff00297B),
                              ),
                              WidthSpace(width: 4),
                              Text(
                                'New Chat',
                                style: GoogleFonts.inter(
                                  color: Color(0xff00297B),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
  }
}