import 'package:dev_mate_ai/features/debug_code/domain/entities/debug_code_request_entity.dart';
import 'package:dev_mate_ai/features/debug_code/domain/repositories/debug_code_repository.dart';

import '../../../../core/services/gemini_service.dart';

class DebugCodeRepositoryImpl implements DebugCodeRepository {
  final GeminiService _geminiService;

  DebugCodeRepositoryImpl(this._geminiService);

  @override
  Future<String> debugCode(DebugCodeRequestEntity request) async {
    final prompt = _buildPrompt(request);
    return await _geminiService.sendMessage(prompt);
  }

  String _buildPrompt(DebugCodeRequestEntity request) {
    return '''
Act as an expert debugging assistant. Fix the issue in the provided code.

Your ONLY responsibility is to debug and fix the source code.

Programming language:
${request.language}

${request.debugContext != null && request.debugContext!.trim().isNotEmpty ? "Error Log/Behavior:\n${request.debugContext}\n" : ""}

Code:

```${request.language}
${request.code}

Instructions:

1. Start directly with the corrected code block. No intro text.
2. Inline comments MUST be added only to the parts that were changed or solved.
3. Provide the explanation section ONLY after the code block is completed.

Here is the code and error details:
- Language: ${request.language}.
${request.debugContext != null && request.debugContext!.trim().isNotEmpty ? "- Error Log/Behavior: ${request.debugContext}\n" : ""}
- Code:
${request.code}
''';
  }
}