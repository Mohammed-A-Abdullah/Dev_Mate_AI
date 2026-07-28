import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:dev_mate_ai/features/explain_code/domain/entity/explain_code_entity.dart';
import 'package:dev_mate_ai/features/explain_code/domain/repositories/explain_code_repository.dart';

import '../../../../core/services/gemini_service.dart';

class ExplainRepositoryImpl implements ExplainCodeRepository {
  final GeminiService _geminiService;
  final FirebaseChatDataSource
  _chatDataSource;

  ExplainRepositoryImpl(
    this._geminiService, {
    required FirebaseChatDataSource chatDataSource,
  }) : _chatDataSource = chatDataSource;

  @override
  Future<String> explainCode(ExplainCodeEntity request) async {
    final prompt = _buildPrompt(request);
    try {
      final result = await _geminiService.sendMessage(prompt);

      if (result.trim().isEmpty) {
        throw Exception('The AI returned an empty response.');
      }

      _saveToHistory(request, result);

      return result;
    } catch (e) {
      throw Exception('Failed to explain code: $e');
    }
  }

  void _saveToHistory(ExplainCodeEntity request, String result) {
    try {
      final promptSummary = [
        'Language: ${request.language}',
        'Code:\n${request.code}',
        if (request.additionalInstructions != null &&
            request.additionalInstructions!.isNotEmpty)
          'Additional Instruction: ${request.additionalInstructions}',
      ].join('\n');

      _chatDataSource.saveQuickToolConversation(
        title: 'Explain Code', 
        type: 'Explain Code', 
        prompt: promptSummary,
        response: result,
      );
    } catch (_) {

    }
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
