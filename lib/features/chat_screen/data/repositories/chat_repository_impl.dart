import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

import '../datasource/firebase_chat_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GeminiService gemnini;
  final FirebaseChatDataSource firebase;

  ChatRepositoryImpl({required this.gemnini, required this.firebase});
  @override
  Future<String>sendMessage(String prompt){
    return gemnini.sendMessage(prompt);
  }
  @override
  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
  }) {
    return firebase.saveMessage(
      chatId: chatId,
      text: text,
      isUser: isUser,
    );
  }
@override
  Future<List<Map<String, dynamic>>> loadMessages(
      String chatId) {
    return firebase.loadMessages(chatId);
  }
  @override
  Future<String> createConversation() {
    return firebase.createConversation();
  }
}
