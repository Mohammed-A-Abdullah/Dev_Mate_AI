import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadmeResultScreen extends StatelessWidget {
  const ReadmeResultScreen({super.key, required this.readme});

  final String readme;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,

          title: Text(
            local.readmeResult,
            style: GoogleFonts.geist(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
            ),
          ),

          bottom: TabBar(
            indicatorColor: colorScheme.primary,
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurface.withValues(alpha:0.5),

            tabs: [
              Tab(
                icon: Icon(Icons.visibility, size: 20.sp),
                text: local.preview,
              ),
              Tab(
                icon: Icon(Icons.code, size: 20.sp),
                text: local.markDown,
              ),
            ],
          ),
        ),

        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final isTablet = width >= 600;
            final isDesktop = width >= 1024;

            final horizontalPadding = isDesktop
                ? 40.0
                : isTablet
                ? 28.0
                : 16.0;

            return TabBarView(
              children: [
                _buildPreview(context, horizontalPadding, isDesktop),

                _buildMarkdown(context, horizontalPadding, isDesktop),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreview(
    BuildContext context,
    double horizontalPadding,
    bool isDesktop,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 24,
            ),
            child: MarkdownBody(
              data: readme,
              selectable: true,

              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: isDesktop ? 16 : 15,
                  height: 1.6,
                ),

                h1: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: isDesktop ? 32 : 28,
                  fontWeight: FontWeight.bold,
                ),

                h2: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: isDesktop ? 25 : 22,
                  fontWeight: FontWeight.bold,
                ),

                h3: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: isDesktop ? 20 : 18,
                  fontWeight: FontWeight.bold,
                ),

                strong: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),

                listBullet: TextStyle(color: colorScheme.onSurface),

                code: TextStyle(
                  color: colorScheme.primary,
                  fontFamily: 'monospace',
                  fontSize: isDesktop ? 14 : 13,
                ),

                codeblockDecoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colorScheme.outline),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMarkdown(
    BuildContext context,
    double horizontalPadding,
    bool isDesktop,
  ) {
    final local = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 12.h,
                    ),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: readme));

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(local.readmeCopied)));
                  },
                  icon: Icon(Icons.copy, size: 18.sp),
                  label: Text(local.copy, style: TextStyle(fontSize: 13.sp)),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isDesktop ? 24 : 16),
                    child: SelectableText(
                      readme,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: isDesktop ? 15 : 14,
                        fontFamily: 'monospace',
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
