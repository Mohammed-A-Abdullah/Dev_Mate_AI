import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static  String apiKey =dotenv.env['GEMINI_API_KEY']!;
  final model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: apiKey,
    systemInstruction: Content.system('''
You are DevMate AI, an expert programming assistant.

Always respond using GitHub Flavored Markdown.

Rules:
- Use headings.
- Use bullet lists.
- Put every code snippet inside triple backticks.
- Always specify the programming language.
- Use markdown tables when comparing.
- Use bold and italic formatting.
- Explain code clearly.
- Never output plain code.
'''),
  );

  Stream<String> sendMessageStream(
    String message, {
    List<Content> history = const [],
  }) async* {
    final chatSession = model.startChat(history: history);

    final stream = chatSession.sendMessageStream(Content.text(message));

    String fullResponse = "";

    await for (final chunk in stream) {
      if (chunk.text != null) {
        fullResponse += chunk.text!;
        yield fullResponse;
      }
    }
  }

  Future<String> sendMessage(
    String message, {
    List<Content> history = const [],
  }) async {
    final chatSession = model.startChat(history: history);

    final response = await chatSession.sendMessage(Content.text(message));

    return response.text ?? "No Response";
  }
}
