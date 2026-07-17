import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:dev_mate_ai/core/widgets/custom_code_element_builder.dart';

class TypewriterMarkdown extends StatefulWidget {
  final String text;

  const TypewriterMarkdown({super.key, required this.text});

  @override
  State<TypewriterMarkdown> createState() => _TypewriterMarkdownState();
}

class _TypewriterMarkdownState extends State<TypewriterMarkdown> {
  String _displayedText = '';
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  @override
  void didUpdateWidget(covariant TypewriterMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // لما نص جديد يوصل من الـ API، بنستدعي دالة الأنيميشن عشان تكمل كتابة
    if (widget.text != oldWidget.text) {
      _animateText();
    }
  }

  void _animateText() {
    _timer?.cancel();
    // التحديث كل 50 مللي ثانية (20 فريم في الثانية) هيخلي الـ Scroll سلس جداً
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          // لو في نص كبير وصل فجأة، بنسرع الكتابة شوية عشان نلحقه
          int remaining = widget.text.length - _currentIndex;
          int charsToAdd = (remaining / 10).ceil();
          if (charsToAdd < 2) charsToAdd = 2; // أقل سرعة هي حرفين في النبضة

          _currentIndex += charsToAdd;
          if (_currentIndex > widget.text.length) {
            _currentIndex = widget.text.length;
          }
          _displayedText = widget.text.substring(0, _currentIndex);
        });
      } else {
        // نوقف التايمر لو وصلنا لآخر النص عشان نوفر استهلاك البطارية
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: _displayedText,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
        h1: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
        h2: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
        h3: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
        listBullet: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.5,
        ),
        strong: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        code: const TextStyle(backgroundColor: Colors.transparent),
        codeblockDecoration: const BoxDecoration(color: Colors.transparent),
        blockSpacing: 12,
      ),
      builders: {'code': CustomCodeElementBuilder()},
    );
  }
}
