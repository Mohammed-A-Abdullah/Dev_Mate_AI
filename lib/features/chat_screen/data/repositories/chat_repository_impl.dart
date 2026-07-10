import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GeminiService gemnini;

  ChatRepositoryImpl({required this.gemnini});
  @override
  Future<String>sendMessage(String prompt){
    return gemnini.sendMessage(prompt);
  }
}