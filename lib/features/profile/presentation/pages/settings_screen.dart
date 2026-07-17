import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = true;
  bool autoSave = true;
  bool smartSuggestions = true;
  bool developerMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111319),
      appBar: AppBar(
        backgroundColor: const Color(0xff111319),
        elevation: 0,
        title: Text(
          'Settings',
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
            _SectionTitle(title: 'Appearance'),
            _SettingsTile(
              title: 'Dark mode',
              subtitle: 'Use the polished dark interface',
              trailing: Switch(
                value: darkMode,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => darkMode = value),
              ),
            ),
            _SettingsTile(
              title: 'Auto-save drafts',
              subtitle: 'Keep your prompts safe while you work',
              trailing: Switch(
                value: autoSave,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => autoSave = value),
              ),
            ),
            SizedBox(height: 16.h),
            _SectionTitle(title: 'Productivity'),
            _SettingsTile(
              title: 'Smart suggestions',
              subtitle: 'Receive better next-step suggestions',
              trailing: Switch(
                value: smartSuggestions,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => smartSuggestions = value),
              ),
            ),
            _SettingsTile(
              title: 'Developer mode',
              subtitle: 'Show deeper controls for advanced workflows',
              trailing: Switch(
                value: developerMode,
                activeColor: const Color(0xffB5C4FF),
                onChanged: (value) => setState(() => developerMode = value),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xff1C1E28),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xff2A2D3A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick tip',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffE2E2EB),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'These settings are local to your current device and can be expanded later with real persistence.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xffC3C5D7),
                    ),
                  ),
                ],
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

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
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
