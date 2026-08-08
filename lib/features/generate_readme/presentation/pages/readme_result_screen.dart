import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadmeResultScreen extends StatelessWidget {
  const ReadmeResultScreen({super.key, required this.readme});

  final String readme;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff111319),

        appBar: AppBar(
          backgroundColor: const Color(0xff111319),
          centerTitle: true,
          title: Text(
            local.readmeResult,
            style: GoogleFonts.geist(
              color: const Color(0xffB5C4FF),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          bottom: TabBar(
            indicatorColor: const Color(0xffB5C4FF),
            labelColor: const Color(0xffB5C4FF),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: const Icon(Icons.visibility), text: local.preview),
              Tab(icon: const Icon(Icons.code), text: local.markDown),
            ],
          ),
        ),

        body: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 1024;
            final maxContentWidth = isDesktop ? 800.0 : double.infinity;

            return TabBarView(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: MarkdownBody(
                        data: readme,
                        selectable: true,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(color: Colors.white, fontSize: 15),
                          h1: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          h2: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          h3: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          strong: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          listBullet: const TextStyle(color: Colors.white),
                          code: const TextStyle(
                            color: Colors.orange,
                            fontFamily: 'monospace',
                          ),
                          codeblockDecoration: BoxDecoration(
                            color: const Color(0xff1E1F26),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xffB5C4FF),
                              ),
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: readme),
                                );

                                if (!context.mounted) return;

                                CustomSnackBar.success(
                                  context,
                                  message: local.readmeCopied,
                                );
                              },
                              icon: const Icon(Icons.copy),
                              label: Text(local.copy),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xff1E1F26),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: SelectableText(
                                readme,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'monospace',
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
