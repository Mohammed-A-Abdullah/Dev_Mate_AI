import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/features/code_review/domain/entities/code_review_request_entity.dart';
import 'package:dev_mate_ai/features/code_review/domain/repositories/code_review_repository.dart';

class CodeReviewRepositoryImpl implements CodeReviewRepository {
  final GeminiService _geminiService;

  CodeReviewRepositoryImpl({required GeminiService geminiService}) : _geminiService = geminiService;
  @override
  Future<String> reviewCode(CodeReviewRequestEntity request)async {
    final prompt= _buildPrompt(request);
    return _geminiService.sendMessage(prompt);
  }

  String _buildPrompt(CodeReviewRequestEntity request) {
    return '''
You are a Senior Software Engineer, Code Reviewer, Software Architect, and Mentor.

Your task is to perform a professional code review exactly like a senior engineer reviewing a Pull Request.

==================================================
PROJECT INFORMATION
==================================================

Programming Language:
${request.language}

Developer Experience:
${request.experienceLevel}

Review Depth:
${request.reviewDepth}

Review Focus:
${request.reviewTypes.join(", ")}

${request.projectContext != null && request.projectContext!.trim().isNotEmpty ? "Project Context:\n${request.projectContext}" : "Project Context: Not provided."}

==================================================
SOURCE CODE
==================================================

```${request.language}
${request.code}
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

${request.reviewTypes.join(", ")}

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

Mention any violated best practices for ${request.language}.

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

${request.experienceLevel}

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
  }

}