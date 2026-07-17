import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool chatAlerts = true;
  bool weeklyDigest = true;
  bool productUpdates = false;
  bool soundEffects = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111319),
      appBar: AppBar(
        backgroundColor: const Color(0xff111319),
        elevation: 0,
        title: Text(
          'Notifications',
          style: GoogleFonts.geist(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xffE2E2EB),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xffB5C4FF)),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            _SectionTitle(title: 'Alerts'),
            _NotifyTile(
              title: 'Chat alerts',
              subtitle: 'Get notified when your AI responses are ready',
              trailing: Switch(
                value: chatAlerts,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => chatAlerts = value),
              ),
            ),
            _NotifyTile(
              title: 'Weekly digest',
              subtitle: 'Receive a summary of your weekly activity',
              trailing: Switch(
                value: weeklyDigest,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => weeklyDigest = value),
              ),
            ),
            SizedBox(height: 16.h),
            _SectionTitle(title: 'Preferences'),
            _NotifyTile(
              title: 'Product updates',
              subtitle: 'Stay informed about new tools and features',
              trailing: Switch(
                value: productUpdates,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => productUpdates = value),
              ),
            ),
            _NotifyTile(
              title: 'Sound effects',
              subtitle: 'Play a subtle sound when actions complete',
              trailing: Switch(
                value: soundEffects,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => soundEffects = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xffB5C4FF),
        ),
      ),
    );
  }
}

class _NotifyTile extends StatelessWidget {
  const _NotifyTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xff1C1E28),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xff2A2D3A)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffE2E2EB),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xffC3C5D7),
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
