import 'package:dev_mate_ai/features/navigation_bar/presentation/widgets/custom_selected_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, this.onTap,required this.currentIndex});
  final int currentIndex;
  final void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: onTap,

                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color(0xffB5C4FF),
                  unselectedItemColor: const Color(0xffC4C6D0),
                  selectedLabelStyle: GoogleFonts.jetBrainsMono(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.55.sp,
                  ),
                  unselectedLabelStyle: GoogleFonts.jetBrainsMono(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.55.sp,
                  ),

                  items: [
                    BottomNavigationBarItem(
                      icon: currentIndex == 0
                          ? CustomSelectedIcon(iconData:Icons.home)
                          : const Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: currentIndex == 1
                          ? CustomSelectedIcon(iconData:Icons.chat_bubble)
                          : const Icon(Icons.chat_bubble_outline),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: currentIndex == 2
                          ? CustomSelectedIcon(iconData:Icons.history)
                          : const Icon(Icons.history),
                      label: 'History',
                    ),
                  ],
                );
  }
}