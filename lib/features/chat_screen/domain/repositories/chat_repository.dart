import 'package:dev_mate_ai/features/chat_screen/domain/entities/chat_message_model.dart';

abstract class ChatRepository {
  
Future<String> sendMessage(
    String prompt, {
    required List<ChatMessage> history,
  });  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
    required String type,
    String? title,
  });

  Future<List<Map<String, dynamic>>> loadMessages(String chatId);
  Future<String> createConversation({
    required String title,
    required String type,
  });
}
