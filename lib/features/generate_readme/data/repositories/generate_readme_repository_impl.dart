import '../../../../core/services/gemini_service.dart';
import '../../../chat_screen/data/datasource/firebase_chat_data_source.dart';
import '../../domain/entities/generate_readme_entity.dart';
import '../../domain/exceptions/readme_generation_exception.dart';
import '../../domain/repositories/generate_readme_repository.dart';

class GenerateReadmeRepositoryImpl implements GenerateReadmeRepository {
  final GeminiService _geminiService;
  final FirebaseChatDataSource _chatDataSource;

  const GenerateReadmeRepositoryImpl(this._geminiService, this._chatDataSource);

  @override
  Future<String> generateReadme(GenerateReadmeEntity request) async {
    final prompt = _buildPrompt(request);

    try {
      final result = await _geminiService.sendMessage(prompt);

      if (result.trim().isEmpty) {
        throw const ReadmeGenerationException(
          'The AI returned an empty response. Please try again.',
        );
      }

      // حفظ السجل في الفايربيس داخل طبقة البيانات
      _saveToHistory(request, result);

      return result;
    } on ReadmeGenerationException {
      rethrow;
    } catch (e) {
      throw const ReadmeGenerationException(
        'Failed to generate README. Please check your connection and try again.',
      );
    }
  }

  void _saveToHistory(GenerateReadmeEntity request, String result) {
    try {
      final promptSummary = [
        'Project Title: ${request.projectTitle}',
        'Description: ${request.projectDescription}',
        'Project Type: ${request.projectType}',
        if (request.features.isNotEmpty)
          'Features: ${request.features.join(', ')}',
        if (request.technologies.isNotEmpty)
          'Technologies: ${request.technologies.join(', ')}',
        if (request.githubLink?.isNotEmpty ?? false)
          'GitHub: ${request.githubLink}',
      ].join('\n');

      _chatDataSource.saveQuickToolConversation(
        title: 'Generate README',
        type: 'Generate README',
        prompt: promptSummary,
        response: result,
      );
    } catch (_) {
      // إخفاء خطأ الحفظ لكي لا يعطل تجربة المستخدم الأساسية
    }
  }

  String _buildPrompt(GenerateReadmeEntity request) {
    final featuresStr = request.features.isEmpty
        ? "Not provided"
        : request.features.map((e) => "- $e").join("\n");

    final techStr = request.technologies.isEmpty
        ? "Not provided"
        : request.technologies.map((e) => "- $e").join("\n");

    final github =
        (request.githubLink == null || request.githubLink!.trim().isEmpty)
        ? "Not provided"
        : request.githubLink!.trim();

    return '''
You are a senior software engineer and technical writer.
Generate a professional GitHub README.md.

Project Information:
- Project Name: ${request.projectTitle}
- Project Description: ${request.projectDescription}
- Project Type: ${request.projectType}
- Main Features:
$featuresStr
- Technologies:
$techStr
- GitHub Repository: $github

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
