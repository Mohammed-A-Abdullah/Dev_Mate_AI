import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String code;
  final String? language;
  final double collapsedHeight;

  const CodeWrapperWidget(
    this.child,
    this.code,
    this.language, {
    super.key,
    this.collapsedHeight = 260,
  });

  @override
  State<CodeWrapperWidget> createState() => _CodeWrapperWidgetState();
}

class _CodeWrapperWidgetState extends State<CodeWrapperWidget> {
  bool _expanded = false;
  bool _copied = false;

  final ScrollController _hController = ScrollController();
  final ScrollController _vController = ScrollController();

  static const _bg = Color(0xff0D1117);
  static const _headerBg = Color(0xff161B22);
  static const _accent = Color(0xffB5C4FF);

  @override
  void dispose() {
    _hController.dispose();
    _vController.dispose();
    super.dispose();
  }

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: const BoxDecoration(color: _bg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: language + copy button
            Container(
              color: _headerBg,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (widget.language ?? 'code').toLowerCase(),
                    style: GoogleFonts.firaCode(
                      color: Colors.white70,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: _copy,
                    child: Row(
                      children: [
                        Icon(
                          _copied ? Icons.check : Icons.copy_rounded,
                          size: 15,
                          color: _copied ? Colors.greenAccent : _accent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _copied ? 'Copied' : 'Copy',
                          style: GoogleFonts.firaCode(
                            color: _copied ? Colors.greenAccent : _accent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Code body: vertical (collapse/fade) + horizontal (scroll) + fade
            Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  constraints: BoxConstraints(
                    maxHeight: _expanded
                        ? double.infinity
                        : widget.collapsedHeight,
                  ),
                  child: SingleChildScrollView(
                    controller: _vController,
                    physics: _expanded
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: Scrollbar(
                      controller: _hController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      child: SingleChildScrollView(
                        controller: _hController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
                if (!_expanded)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 60,
                    child: IgnorePointer(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, _bg],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            if (_needsToggle())
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: _headerBg,
                  child: Center(
                    child: Text(
                      _expanded ? 'Show less' : 'Show more',
                      style: GoogleFonts.firaCode(
                        color: _accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _needsToggle() {
    return widget.code.split('\n').length > 12;
  }
}
