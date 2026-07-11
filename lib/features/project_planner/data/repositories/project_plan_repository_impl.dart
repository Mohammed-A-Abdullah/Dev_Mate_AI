import '../../domain/entities/project_plan_request.dart';
import '../../domain/repositories/i_project_plan_repository.dart';
import '../../../../core/services/gemini_service.dart';

class ProjectPlanRepositoryImpl implements IProjectPlanRepository {
  final GeminiService _geminiService;

  ProjectPlanRepositoryImpl(this._geminiService);

  @override
  Future<String> generatePlan(ProjectPlanRequest request) async {
    final prompt = _buildPrompt(request);
    return await _geminiService.sendMessage(prompt);
  }

  String _buildPrompt(ProjectPlanRequest request) {
    return '''
You are a Senior Software Architect, Technical Lead, Product Manager, and Agile Project Planner.

Your task is to create a COMPLETE professional project development plan based on the information below.

=========================
PROJECT INFORMATION
=========================

Project Title:
${request.title.trim().isEmpty ? "Not provided" : request.title.trim()}

Project Description:
${request.description.trim().isEmpty ? "Not provided" : request.description.trim()}

Platform:
${request.platform}

Programming Language:
${request.programmingLanguage}

Developer Experience:
${request.experienceLevel}

Architecture:
${request.architecture}

Deadline:
${request.deadline}

Deployment Target:
${request.deploymentTarget}

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
  }
}
