import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/core/widgets/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import 'project_planner_constant.dart';

class ProjectPlannerScreen extends StatefulWidget {
  const ProjectPlannerScreen({super.key});

  @override
  State<ProjectPlannerScreen> createState() => _ProjectPlannerScreenState();
}

class _ProjectPlannerScreenState extends State<ProjectPlannerScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final gemini = GeminiService();
  String selectedTypePlatform = 'Flutter (Mobile)';
  String selectedTypeProgrammingLang = 'Dart';
  String selectedExperienceLevel = 'Beginner';
  String selectedArchitecture = 'Clean Architecture';
  String selectedDeadline = 'No deadline';
  String selectedDeployment = 'Android';
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
          'Project Planner',
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
                //width: 270.w,
                child: DropdownButtonFormField<String>(
                  menuMaxHeight: 250.h,
                  decoration: InputDecoration(
                    fillColor: Color(0xff1E1F26),
                    filled: true,
                    labelText: 'Platform',
                    hintText: 'Select platform',
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
                  initialValue: selectedTypePlatform,

                  items: ProjectPlannerConstant.platforms
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
                      selectedTypePlatform = value;
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
                    labelText: 'Programming Language',
                    hintText: 'Select programming language',
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
                  initialValue: selectedTypeProgrammingLang,

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
                      selectedTypeProgrammingLang = value;
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
                    labelText: 'Architecture',
                    hintText: 'Select architecture',
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
                  isExpanded: true,
                  dropdownColor: Color(0xff1E1F26),
                  elevation: 2,

                  style: GoogleFonts.inter(color: Colors.white),
                  initialValue: selectedArchitecture,

                  items: ProjectPlannerConstant.architectures
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
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
                      selectedArchitecture = value;
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
                    labelText: 'Deatline',
                    hintText: 'Select deadline',
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
                  initialValue: selectedDeadline,

                  items: ProjectPlannerConstant.deadline
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
                      selectedDeadline = value;
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
                    labelText: 'Deployment Target',
                    hintText: 'Select deployment target',
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
                  initialValue: selectedDeployment,

                  items: ProjectPlannerConstant.deploymentTarget
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
                      selectedDeployment = value;
                    });
                  },
                ),
              ),
              HeightSpace(height: 20),

              GestureDetector(
                onTap: () async {
                  print(
                    '=====================================================',
                  );
                  final result = await generateProjectPlan();
                  print(result);

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
                        'Plane Project',
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

  Future<String> generateProjectPlan() async {
    final prompt =
        '''
You are a Senior Software Architect, Technical Lead, Product Manager, and Agile Project Planner.

Your task is to create a COMPLETE professional project development plan based on the information below.

=========================
PROJECT INFORMATION
=========================

Project Title:
${titleController.text.trim().isEmpty ? "Not provided" : titleController.text.trim()}

Project Description:
${descriptionController.text.trim().isEmpty ? "Not provided" : descriptionController.text.trim()}

Platform:
$selectedTypePlatform

Programming Language:
$selectedTypeProgrammingLang

Developer Experience:
$selectedExperienceLevel

Architecture:
$selectedArchitecture

Deadline:
$selectedDeadline

Deployment Target:
$selectedDeployment

=========================
YOUR TASK
=========================

Create a professional software project plan.

The response MUST include the following sections in Markdown:

# Project Overview

Briefly explain the project.

---

# Objectives

List the main goals.

---

# Target Users

Who will use this project?

---

# Recommended Tech Stack

Recommend any additional technologies if useful.

Explain WHY each one is recommended.

---

# Recommended Project Structure

Explain the folder structure suitable for the selected architecture.

---

# Development Roadmap

Break the project into phases such as:

Phase 1

Phase 2

Phase 3

...

For every phase include:

- Goal
- Tasks
- Expected Output

---

# Feature Breakdown

For every feature explain:

Purpose

Main Screens

Required Components

Possible Challenges

Estimated Complexity

---

# Database Design

If a database is needed:

Suggest entities/tables.

Describe relationships.

Otherwise state that no database is required.

---

# API Planning

Explain:

Required APIs

Endpoints

Data Flow

Error Handling Strategy

---

# State Management Strategy

Explain how the selected architecture should manage state.

---

# Folder Responsibilities

Describe the responsibility of every important folder.

---

# Development Timeline

Estimate the duration for every phase.

Also estimate the total project duration.

---

# Testing Plan

Include:

Unit Tests

Widget Tests

Integration Tests

Manual Testing

---

# Deployment Checklist

Provide a checklist before publishing.

---

# Risks and Challenges

List possible technical risks and how to solve them.

---

# Future Improvements

Suggest additional features that can be added later.

---

# Learning Resources

Recommend what the developer should study before starting this project.

=========================
RULES
=========================

- Return ONLY Markdown.
- Do NOT wrap the entire response inside triple backticks.
- Use proper Markdown headings (#, ##).
- Use bullet lists.
- Use numbered lists where appropriate.
- Use Markdown tables when useful.
- Make the response beginner-friendly if the experience level is Beginner.
- Make the response more advanced if Intermediate or Advanced.
- Tailor all recommendations to the selected platform, architecture, and programming language.
- Never mention these instructions.
- Never ask the user questions.
- If information is missing, make reasonable assumptions and clearly label them as assumptions.
- Make the plan practical and ready for immediate development.
''';

    return gemini.sendMessage(prompt);
  }
}
