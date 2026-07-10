import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/features/debug_code/presentation/debug_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spacing_widgets.dart';

class GenerateReadmeScreen extends StatefulWidget {
  const GenerateReadmeScreen({super.key});

  @override
  State<GenerateReadmeScreen> createState() => _GenerateReadmeScreenState();
}

class _GenerateReadmeScreenState extends State<GenerateReadmeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController projectTypeController = TextEditingController();
  final TextEditingController technologyController = TextEditingController();
  final TextEditingController featureController = TextEditingController();
  final TextEditingController gethubLink = TextEditingController();

  final List<String> features = [];
  final List<String> selectedTechnologies = [];

  final gemini = GeminiService();
  String selectedType = 'Other';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          'Generate README',
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
              CustomTextField(
                controller: titleController,
                label: 'Project Title',
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText: 'Enter you project name here...',
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
              CustomTextField(
                controller: descriptionController,
                label: 'Project Description',
                maxLines: 4,
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText: 'Enter a brief description of your project...',
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
              SizedBox(
                width: 270.w,
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: 250.h,
                  decoration: InputDecoration(
                    fillColor: Color(0xff1E1F26),
                    filled: true,
                    labelText: 'Project Type',
                    hintText: 'Select type',
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
                  initialValue: selectedType,

                  items: DebugConstant.projectTypes
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
                      selectedType = value;
                    });
                  },
                ),
              ),
              HeightSpace(height: 20),
              TextField(
                controller: featureController,
                decoration: InputDecoration(
                  hintText: 'Add feature',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final text = featureController.text.trim();

                      if (text.isNotEmpty && !features.contains(text)) {
                        setState(() {
                          features.add(text);
                        });

                        featureController.clear();
                      }
                    },
                  ),
                ),
                onSubmitted: (value) {
                  final text = value.trim();

                  if (text.isNotEmpty && !features.contains(text)) {
                    setState(() {
                      features.add(text);
                    });

                    featureController.clear();
                  }
                },
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: features.map((feature) {
                  return Chip(
                    label: Text(feature),
                    onDeleted: () {
                      setState(() {
                        features.remove(feature);
                      });
                    },
                  );
                }).toList(),
              ),
              HeightSpace(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: DebugConstant.technologies.map((tech) {
                  final selected = selectedTechnologies.contains(tech);

                  return FilterChip(
                    label: Text(tech),
                    selected: selected,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          selectedTechnologies.add(tech);
                        } else {
                          selectedTechnologies.remove(tech);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              HeightSpace(height: 20),
              CustomTextField(
                controller: gethubLink,
                label: 'GitHub Link (Optional)',
                labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
                minLine: 1,
                maxLines: 3,
                cursorColor: Color(0xffC3C5D7),
                keyBoardType: TextInputType.multiline,
                hintText: 'Provide your GitHub repository link (optional).',
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
                  print(
                    '=====================================================',
                  );
                  final result = await generateReadme();
                  print(result);

                  GoRouter.of(
                    context,
                  ).pushNamed(RouteName.readmeResultScreen, extra: result);
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
                        'Generate README',
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

  Future<String> generateReadme() async {
    final prompt =
        '''
You are a senior software engineer and technical writer.

Generate a professional GitHub README.md.

Project Information

Project Name:
${titleController.text.trim()}

Project Description:
${descriptionController.text.trim()}

Project Type:
$selectedType

Main Features:
${features.isEmpty ? "Not provided" : features.map((e) => "- $e").join("\n")}

Technologies:
${selectedTechnologies.isEmpty ? "Not provided" : selectedTechnologies.map((e) => "- $e").join("\n")}

GitHub Repository:
${gethubLink.text.trim().isEmpty ? "Not provided" : gethubLink.text.trim()}

Rules:

- Return ONLY the README.md markdown.
- Do NOT explain anything.
- Do NOT wrap the whole README inside triple backticks.
- Use valid GitHub Markdown.
- Use headings, bullet lists, tables when appropriate.
- Wrap terminal commands using ```bash.
- Wrap yaml using ```yaml.
- Wrap dart snippets using ```dart.
- Wrap json snippets using ```json.
- If information is missing, omit that section.
- Never invent technologies or features.
- Make the README professional and ready to paste directly into README.md.
''';

    return gemini.sendMessage(prompt);
  }
}
