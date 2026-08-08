import 'package:dev_mate_ai/core/widgets/custom_app_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_code_element_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class CustomAiModelAnswerScreen extends StatefulWidget {
  const CustomAiModelAnswerScreen({super.key, required this.data});

  final String data;

  @override
  State<CustomAiModelAnswerScreen> createState() =>
      _CustomAiModelAnswerScreenState();
}

class _CustomAiModelAnswerScreenState extends State<CustomAiModelAnswerScreen> {

  bool _readyToRender = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() => _readyToRender = true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: 'Answer'),
      body: !_readyToRender
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                final bool isTablet = width >= 600;
                final bool isDesktop = width >= 1024;

                final double horizontalPadding = isDesktop
                    ? 40
                    : isTablet
                    ? 28
                    : 16;

                final double maxContentWidth = isDesktop
                    ? 1000
                    : isTablet
                    ? 850
                    : double.infinity;

                final double bodyFontSize = isDesktop
                    ? 17
                    : isTablet
                    ? 16
                    : 15;

                final double h1FontSize = isDesktop
                    ? 30
                    : isTablet
                    ? 26
                    : 22;

                final double h2FontSize = isDesktop
                    ? 25
                    : isTablet
                    ? 22
                    : 20;

                final double h3FontSize = isDesktop
                    ? 21
                    : isTablet
                    ? 19
                    : 18;

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),

                    child: Markdown(
                      data: widget.data,
                      selectable: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 20,
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: bodyFontSize,
                          height: 1.6,
                        ),

                        h1: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: h1FontSize,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),

                        h2: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: h2FontSize,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),

                        h3: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: h3FontSize,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),

                        listBullet: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: bodyFontSize,
                          height: 1.5,
                        ),

                        strong: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),

                        code: const TextStyle(
                          backgroundColor: Colors.transparent,
                        ),

                        codeblockDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),

                        blockSpacing: isDesktop ? 18 : 12,
                      ),

                      builders: {'code': CustomCodeElementBuilder()},
                    ),
                  ),
                );
              },
            ),
    );
  }
}
