import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_row_divider.dart';
import 'package:dev_mate_ai/features/profile/presentation/widgets/custom_setting_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSettingGroupe extends StatefulWidget {
  const CustomSettingGroupe({
    super.key,
    required this.onAccountSettingsTap,
    required this.onNotificationsTap,
    required this.onAboutTap,
    required this.onLogoutTap,
  });
  final VoidCallback onAccountSettingsTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  @override
  State<CustomSettingGroupe> createState() => _CustomSettingGroupeState();
}

class _CustomSettingGroupeState extends State<CustomSettingGroupe> {
  bool _isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1C1E28),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Column(
        children: [
          CustomSettingRow(
            icon: Icons.manage_accounts_outlined,
            title: 'Account Settings',
            onTap: widget.onAccountSettingsTap,
          ),
          const CustomRowDivider(),
          CustomSettingRow(
            icon: Icons.dark_mode_outlined,
            title: 'Theme',
            trailing: Row(
              mainAxisSize: MainAxisSize
                  .min,
              children: [
                Text(
                  _isDarkMode ? 'Dark' : 'Light',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xffC3C5D7),
                  ),
                ),
                WidthSpace(width: 4.w),
                SizedBox(
                  height: 24.h,
                  child: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: _isDarkMode,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeThumbColor: const Color(0xffB5C4FF),
                      onChanged: (value) {
                        setState(() => _isDarkMode = value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CustomRowDivider(),
          CustomSettingRow(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: widget.onNotificationsTap,
          ),
          const CustomRowDivider(),
          CustomSettingRow(
            icon: Icons.info_outline,
            title: 'About DevMate AI',
            onTap: widget.onAboutTap,
          ),
          const CustomRowDivider(),
          CustomSettingRow(
            icon: Icons.logout,
            title: 'Logout',
            titleColor: const Color(0xffFF8A8A),
            iconColor: const Color(0xffFF8A8A),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: const Color(0xffFF8A8A),
            ),
            onTap: widget.onLogoutTap,
          ),
        ],
      ),
    );
  }
}
