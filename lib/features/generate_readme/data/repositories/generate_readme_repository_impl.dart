import 'package:dev_mate_ai/features/generate_readme/domain/entities/generate_readme_entity.dart';
import 'package:dev_mate_ai/features/generate_readme/domain/repositories/generate_readme_repository.dart';

import '../../../../core/services/gemini_service.dart';

class ReadmeRepositoryImpl implements GenerateReadmeRepository {
  final GeminiService _geminiService;

  ReadmeRepositoryImpl(this._geminiService);

  @override
  Future<String> generateReadme(GenerateReadmeEntity request) async {
    final prompt = _buildPrompt(request);
    return await _geminiService.sendMessage(prompt);
  }

  String _buildPrompt(GenerateReadmeEntity request) {
    return '''
You are a senior software engineer and technical writer.

Generate a professional GitHub README.md.

Project Information

Project Name:
${request.projectTitle}

Project Description:
${request.projectDescription}

Project Type:
${request.projectType}

Main Features:
${request.features.isEmpty ? "Not provided" : request.features.map((e) => "- $e").join("\n")}

Technologies:
${request.technologies.isEmpty ? "Not provided" : request.technologies.map((e) => "- $e").join("\n")}

GitHub Repository:
${request.githubLink?.trim().isEmpty ?? true ? "Not provided" : request.githubLink!.trim()}

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
  }
}
