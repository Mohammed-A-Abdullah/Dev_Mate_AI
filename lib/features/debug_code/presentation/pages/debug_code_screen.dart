import 'package:dev_mate_ai/core/routing/route_name.dart';
import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/core/widgets/language_helper.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/custom_text_field.dart';

class DebugCodeScreen extends StatefulWidget {
  const DebugCodeScreen({super.key});

  @override
  State<DebugCodeScreen> createState() => _DebugCodeScreenState();
}

class _DebugCodeScreenState extends State<DebugCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController errorLogController = TextEditingController();
  final gemini = GeminiService();
  int _lineCount = 1;
  late CodeController codeController;

  String? selectedLanguage = 'Dart';
  @override
  void initState() {
    super.initState();
    codeController = CodeController(
      text: '',
      language: LanguageHelper.languageModes[selectedLanguage]!,
    );
    _codeController.addListener(() {
      final lines = _codeController.text.split('\n').length;
      if (lines != _lineCount) {
        setState(() {
          _lineCount = lines;
        });
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // State variable to track the selection

    return Scaffold(
      backgroundColor: Color(0xff111319),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff111319),
        title: Text(
          'Explain Code',
          style: GoogleFonts.geist(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xffB5C4FF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(height: 35),
              SizedBox(
                width: 250.w,
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: 250.h,
                  decoration: InputDecoration(
                    fillColor: Color(0xff1E1F26),
                    filled: true,
                    labelText: 'Language',
                    hintText: 'Select language',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xff6F7385),
                      fontSize: 14.sp,
                    ),
                    labelStyle: TextStyle(color: Color(0xff6F7385)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff434654)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff434654)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: const Icon(
                      Icons.code,
                      color: Color(0xffC3C5D7),
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xffC3C5D7),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  itemHeight: 48.0,
                  isDense: true,
                  dropdownColor: Color(0xff1E1F26),
                  elevation: 2,

                  style: GoogleFonts.inter(color: Colors.white),
                  initialValue: selectedLanguage,

                  items: LanguageHelper.languages
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      selectedLanguage = value;

                      codeController.language =
                          LanguageHelper.languageModes[value]!;
                    });
                  },
                ),
              ),
              HeightSpace(height: 20),
              Container(
                height: 350.h,
                decoration: BoxDecoration(
                  color: Color(0xff1E1F26),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CodeField(
                  expands: true,
                  padding: EdgeInsets.all(5),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  controller: codeController,
                  textStyle: GoogleFonts.sourceCodePro(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              HeightSpace(height: 20),
              CustomTextField(
                controller: errorLogController,
                label: 'Debug & Error Instructions (Optional)',
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                minLine: 1,
                maxLines: 3,
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText: 'Provide any specific instructions or context for debugging the code.',
                prefixIcon: const Icon(
                  Icons.edit_note,
                  color: Color(0xffC3C5D7),
                ),
                fillColor: const Color(0xff1E1F26),
                borderColor: const Color(0xff434654),
                radius: 18.r,
                textStyle: GoogleFonts.inter(color: Colors.white),
                hintTextStyle: GoogleFonts.inter(
                  color: const Color(0xff6F7385),
                  fontSize: 14.sp,
                ),
              ),
              HeightSpace(height: 20),
              GestureDetector(
                onTap: () async {
                  final result = await explainCode(
                    language: selectedLanguage ?? 'Dart',
                    code: codeController.text.trim(),
                    errorLog: errorLogController.text,
                  );
                  GoRouter.of(
                    context,
                  ).pushNamed(RouteName.ansewerEplainCode, extra: result);
                },
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffB5C4FF),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Debug Code',
                        style: GoogleFonts.inter(
                          color: const Color(0xff00297B),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.55.sp,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: const Color(0xff00297B),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> explainCode({
    required String language,
    required String code,
    String? errorLog,
  }) async {
    final prompt =
        '''
Act as an expert debugging assistant. Fix the issue in the provided code.

Your ONLY responsibility is to debug and fix the source code.

Programming language:
$language

${errorLog != null && errorLog.trim().isNotEmpty ? "Error Log/Behavior:\n$errorLog\n" : ""}

Code:

```$language
$code

Instructions:

1. Start directly with the corrected code block. No intro text.
2. Inline comments MUST be added only to the parts that were changed or solved.
3. Provide the explanation section ONLY after the code block is completed.

Here is the code and error details:
- Language: $language.
- Error Log/Behavior: $errorLog
- Code:
$code
''';

    return gemini.sendMessage(prompt);
  }
}
