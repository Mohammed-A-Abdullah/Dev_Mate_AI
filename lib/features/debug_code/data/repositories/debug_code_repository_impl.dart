import 'package:dev_mate_ai/features/debug_code/domain/entities/debug_code_request_entity.dart';
import 'package:dev_mate_ai/features/debug_code/domain/repositories/debug_code_repository.dart';

import '../../../../core/services/gemini_service.dart';

class DebugCodeRepositoryImpl implements DebugCodeRepository {
  final GeminiService _geminiService;

  DebugCodeRepositoryImpl(this._geminiService);

  @override
  Future<String> debugCode(DebugCodeRequestEntity request) async {
    final prompt = _buildPrompt(request);
    return _geminiService.sendMessage(prompt);
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
