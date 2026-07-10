import 'package:dev_mate_ai/core/widgets/custom_code_element_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultModelScreen extends StatelessWidget {
  const ResultModelScreen({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111319),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff111319),
        title: Text(
          'Answer',
          style: GoogleFonts.geist(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffB5C4FF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MarkdownBody(
                data: data,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  // تنسيقات النصوص العادية التي وضعناها مسبقاً
                  p: const TextStyle(color: Colors.white, fontSize: 15),
                  h1: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  h2: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  h3: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  listBullet: const TextStyle(color: Colors.white),
                  strong: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
          
                  // !! مهم جداً: نخفي خلفية الكود الافتراضية الخاصة بالحزمة لنستخدم تصميمنا !!
                  code: const TextStyle(backgroundColor: Colors.transparent),
                  codeblockDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                // --- السطر الجديد هنا ---
                builders: {'code': CustomCodeElementBuilder()},
              ),
            ],
          ),
        ),
      ),
    );
  }
}