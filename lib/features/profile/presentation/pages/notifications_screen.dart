import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool pushEnabled = true;
  bool chatEnabled = true;
  bool readmeEnabled = true;
  bool analysisEnabled = true;
  bool updateEnabled = true;
  bool marketingEnabled = false;
  bool summaryEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Notifications'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Push Notifications'),
            HeightSpace(height: 12.h),
            _buildSettingsCard(
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications,
                  iconColor: const Color(0xffA855F7),
                  title: 'Enable Push Notifications',
                  subtitle: 'Receive notifications on your device',
                  value: pushEnabled,
                  onChanged: (val) => setState(() => pushEnabled = val),
                ),
              ],
            ),
            HeightSpace(height: 24.h),
            _buildSectionTitle('Notification Preferences'),
            HeightSpace(height: 12.h),
            _buildSettingsCard(
              children: [
                _buildSwitchTile(
                  icon: Icons.chat_bubble_outline,
                  iconColor: const Color(0xff3B82F6),
                  title: 'Chat Notifications',
                  subtitle: 'Notify me about new chat messages',
                  value: chatEnabled,
                  onChanged: (val) => setState(() => chatEnabled = val),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.description_outlined,
                  iconColor: const Color(0xff6366F1),
                  title: 'README Notifications',
                  subtitle: 'Notify me when a README is generated',
                  value: readmeEnabled,
                  onChanged: (val) => setState(() => readmeEnabled = val),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.analytics_outlined,
                  iconColor: const Color(0xff10B981),
                  title: 'Analysis Notifications',
                  subtitle: 'Notify me about completed analysis',
                  value: analysisEnabled,
                  onChanged: (val) => setState(() => analysisEnabled = val),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.system_update_alt,
                  iconColor: const Color(0xffEC4899),
                  title: 'Update Notifications',
                  subtitle: 'Notify me about app updates',
                  value: updateEnabled,
                  onChanged: (val) => setState(() => updateEnabled = val),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.mail_outline,
                  iconColor: const Color(0xff3B82F6),
                  title: 'Marketing Emails',
                  subtitle: 'Receive emails about tips and offers',
                  value: marketingEnabled,
                  onChanged: (val) => setState(() => marketingEnabled = val),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.calendar_today_outlined,
                  iconColor: const Color(0xff10B981),
                  title: 'Weekly Summary',
                  subtitle: 'Get a weekly summary of your activity',
                  value: summaryEnabled,
                  onChanged: (val) => setState(() => summaryEnabled = val),
                ),
              ],
            ),
            HeightSpace(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: const Color(0xff8E92A8),
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1A1D2D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xff2A2D3D), width: 1),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xff8E92A8),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
            child: Transform.scale(
              scale: 0.6,
              child: Switch(
                value: value,
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xff6084FF),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xff2A2D3D),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: const Color(0xff2A2D3D),
      height: 1,
      thickness: 1,
      indent: 64.w,
      endIndent: 16.w,
    );
  }
}
