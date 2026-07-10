import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/features/project_planner/presentation/pages/project_planner_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class CodeReviewScreen extends StatefulWidget {
  const CodeReviewScreen({super.key});

  @override
  State<CodeReviewScreen> createState() => _CodeReviewScreenState();
}

class _CodeReviewScreenState extends State<CodeReviewScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController errorLogController = TextEditingController();
  final gemini = GeminiService();
  int _lineCount = 1;
  late CodeController codeController;

  String? selectedLanguage = 'Dart';
  String? selectedExperienceLevel = 'Beginner';
  String? selectedReviewDepth = 'Quick Review';

  final List<String> reviewOptions = [
    'Code Quality',
    'Performance',
    'Security',
    'Bugs',
    'Best Practices',
    'Clean Code',
    'Readability',
    'Maintainability',
    'Architecture',
    'Memory Usage',
    'Error Handling',
    'Testing Suggestions',
    'Documentation',
    'Accessibility (UI)',
  ];
  final List<String> selectedReviewOptions = [];

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
          'Code Review',
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
              SizedBox(
                //width: 270.w,
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: 250.h,
                  decoration: InputDecoration(
                    fillColor: Color(0xff1E1F26),
                    filled: true,
                    labelText: 'Experience Level',
                    hintText: 'Select experience level',
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
                  initialValue: selectedExperienceLevel,

                  items: ProjectPlannerConstant.experienceLevel
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
                      selectedExperienceLevel = value;
                    });
                  },
                ),
              ),
              HeightSpace(height: 20),
              SizedBox(
                //width: 270.w,
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: 250.h,
                  decoration: InputDecoration(
                    fillColor: Color(0xff1E1F26),
                    filled: true,
                    labelText: 'Review Depth',
                    hintText: 'Select review depth',
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
                  initialValue: selectedReviewDepth,

                  items: ProjectPlannerConstant.reviewDepth
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
                      selectedReviewDepth = value;
                    });
                  },
                ),
              ),
              HeightSpace(height: 20),
              InputDecorator(
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
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: reviewOptions.map((tech) {
                    final selected = selectedReviewOptions.contains(tech);

                    return FilterChip(
                      label: Text(tech),
                      selected: selected,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedReviewOptions.add(tech);
                          } else {
                            selectedReviewOptions.remove(tech);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              HeightSpace(height: 20),

              HeightSpace(height: 20),
              CustomTextField(
                controller: errorLogController,
                label: 'Project Context (Optional)',
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                minLine: 1,
                maxLines: 3,
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText:
                    'ex: This is a login screen using Firebase Authentication....',
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
                  final result = await codeReview(
                    language: selectedLanguage ?? 'Dart',
                    code: codeController.text.trim(),
                    reviewTypes: selectedReviewOptions,
                    experienceLevel: selectedExperienceLevel ?? 'Beginner',
                    reviewDepth: selectedReviewDepth ?? 'Quick Review',
                    projectContext: errorLogController.text,
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

  Future<String> codeReview({
    required String language,
    required String code,
    required List<String> reviewTypes,
    required String experienceLevel,
    required String reviewDepth,
    String? projectContext,
  }) async {
    final prompt =
        '''
You are a Senior Software Engineer, Code Reviewer, Software Architect, and Mentor.

Your task is to perform a professional code review exactly like a senior engineer reviewing a Pull Request.

==================================================
PROJECT INFORMATION
==================================================

Programming Language:
$language

Developer Experience:
$experienceLevel

Review Depth:
$reviewDepth

Review Focus:
${reviewTypes.join(", ")}

${projectContext != null && projectContext.trim().isNotEmpty ? "Project Context:\n$projectContext" : "Project Context: Not provided."}

==================================================
SOURCE CODE
==================================================

```$language
$code
==================================================
REVIEW INSTRUCTIONS

Review ONLY the code provided.

Do NOT invent functionality.

Do NOT assume missing files.

Only review what actually exists.

If something cannot be verified because context is missing, clearly mention that.

==================================================
OUTPUT FORMAT
Overall Score

Give a score from 1–10.

Example:

Overall Score: 8.7/10

Summary

Write a concise summary (2-5 sentences).

Strengths

Mention everything that is done well.

Use bullet points.

Issues Found

Group issues into four categories.

Critical

List critical issues.

If none:

"No critical issues found."

High

List high severity issues.

Medium

List medium severity issues.

Low

List minor improvements.

For every issue include:

• Severity
• File/Location (if identifiable)
• Problem
• Why it matters
• Recommendation

Review by Selected Categories

ONLY review these categories:

${reviewTypes.join(", ")}

For each selected category:

Give a score out of 10.
Explain the current situation.
Suggest improvements.

Example:

Performance

Score: 8/10

Explanation...

Recommendations...

Repeat for every selected review category.

Best Practices

Mention any violated best practices for $language.

Code Smells

Mention any code smells.

If none, say so.

Refactoring Suggestions

Suggest cleaner approaches.

Explain WHY.

Improved Code

If improvements are needed, provide an improved version.

Use one markdown code block.

Include inline comments ONLY where changes were made.

If no changes are necessary, write:

"No rewritten code required."

Learning Tips

Since the developer is at this level:

$experienceLevel

Provide learning advice appropriate to this level.

Final Verdict

Conclude whether the code is:

🟢 Production Ready

🟡 Needs Minor Improvements

🟠 Needs Refactoring

🔴 Not Recommended for Production

==================================================

IMPORTANT RULES

Never skip any section.
Never invent bugs.
Be objective.
Be constructive.
Explain every issue clearly.
Keep explanations concise but professional.

Return the entire response in Markdown.
''';

    return gemini.sendMessage(prompt);
  }
}
