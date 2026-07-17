import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String apiKey =
      "AQ.Ab8RN6KhOTCdkjI-NwNz9O2oo11r0wAcwQsO53iDGDK40TjKaQ";
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

  Stream<String> sendMessageStream(String message) async* {
    final stream = model.generateContentStream([Content.text(message)]);

    String fullResponse = "";

    await for (final chunk in stream) {
      if (chunk.text != null) {
        fullResponse += chunk.text!;
        yield fullResponse;
      }
    }
  }
  Future<String> sendMessage(String message) async {
    final response = await model.generateContent([Content.text(message)]);

    return response.text ?? "No Response";
  }

}
