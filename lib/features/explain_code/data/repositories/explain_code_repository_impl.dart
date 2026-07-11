import 'package:dev_mate_ai/features/explain_code/domain/entity/explain_code_entity.dart';
import 'package:dev_mate_ai/features/explain_code/domain/repositories/explain_code_repository.dart';

import '../../../../core/services/gemini_service.dart';

class ExplainRepositoryImpl implements ExplainCodeRepository {
  final GeminiService _geminiService;

  ExplainRepositoryImpl(this._geminiService);

  @override
  Future<String> explainCode(ExplainCodeEntity request) async {
    final prompt = _buildPrompt(request);
    return await _geminiService.sendMessage(prompt);
  }

  String _buildPrompt(ExplainCodeEntity request) {
    return '''
You are an expert programming tutor.

Your ONLY responsibility is to explain source code.

Programming language:
${request.language}

${request.additionalInstructions != null && request.additionalInstructions!.trim().isNotEmpty ? "Additional Instructions:\n${request.additionalInstructions}\n" : ""}

Code:

```${request.language}
${request.code}

Instructions:

First provide a short summary of what the code does.
Explain the code section by section.
Explain every important function.
Explain important variables.
Mention any design pattern used.
Mention the time complexity if relevant.
Mention the space complexity if relevant.
Point out any bad practices.
Suggest improvements if possible.
Keep explanations beginner friendly.
Use markdown headings and bullet lists.
If the input is NOT valid source code,
respond ONLY with:

Please provide valid source code to explain.
''';
  }
}
