import 'package:dev_mate_ai/features/debug_code/domain/entities/debug_code_request_entity.dart';
import 'package:dev_mate_ai/features/debug_code/domain/repositories/debug_code_repository.dart';

import '../../../../core/services/gemini_service.dart';
import '../../../chat_screen/data/datasource/firebase_chat_data_source.dart';

class DebugCodeRepositoryImpl implements DebugCodeRepository {
  final GeminiService _geminiService;
  final FirebaseChatDataSource _chatDataSource;

  DebugCodeRepositoryImpl(
    this._geminiService, {
    required FirebaseChatDataSource chatDataSource,
  }) : _chatDataSource = chatDataSource;

  @override
  Future<String> debugCode(DebugCodeRequestEntity request) async {
    final prompt = _buildPrompt(request);
    try {
      final result = await _geminiService.sendMessage(prompt);

      if (result.trim().isEmpty) {
        throw Exception('The AI returned an empty response.');
      }

      _saveToHistory(request, result);

      return result;
    } catch (e) {
      throw Exception('Failed to debug code: $e'); 
    }
  }

  void _saveToHistory(DebugCodeRequestEntity request, String result) {
    try {
      final promptSummary = [
        'Language: ${request.language}',
        'Code:\n${request.code}',
        if (request.debugContext != null && request.debugContext!.isNotEmpty)
          'Debug Context: ${request.debugContext}',
      ].join('\n');

      _chatDataSource.saveQuickToolConversation(
        title: 'Debug Code',
        type: 'Debug',
        prompt: promptSummary,
        response: result,
      );
    } catch (_) {}
  }

  String _buildPrompt(DebugCodeRequestEntity request) {
    final hasContext =
        request.debugContext != null && request.debugContext!.trim().isNotEmpty;

    return '''
Act as an expert debugging assistant.

Your task is to debug the provided code and return a corrected version.

Rules:
1. Start with the solved code.
2. Do not add a long introduction.
3. Add inline comments only where you changed something important.
4. After the code, you may add a short explanation section.

Programming language:
${request.language}

${hasContext ? 'Error Log / Behavior:\n${request.debugContext}\n' : ''}

Code:
```${request.language}
${request.code}
````

Return format:

* Corrected code first
* Then a short explanation of the fix
  ''';
  }
}
