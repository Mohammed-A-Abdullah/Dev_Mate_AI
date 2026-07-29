import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/entities/chat_message_model.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../datasource/firebase_chat_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GeminiService gemnini;
  final FirebaseChatDataSource firebase;

  ChatRepositoryImpl({required this.gemnini, required this.firebase});
@override
  Future<String> sendMessage(
    String prompt, {
    List<ChatMessage> history = const [],
  }) {
    final List<Content> geminiHistory = history.map((msg) {
      return msg.isUser
          ? Content.text(msg.text) 
          : Content.model([TextPart(msg.text)]); 
    }).toList();

    return gemnini.sendMessage(prompt, history: geminiHistory);
  }

  @override
  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
    required String type,
    String? title,
  }) {
    return firebase.saveMessage(
      chatId: chatId,
      text: text,
      isUser: isUser,
      type: type,
      title: title,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> loadMessages(String chatId) {
    return firebase.loadMessages(chatId);
  }

  @override
  Future<String> createConversation({
    required String title,
    required String type,
  }) {
    return firebase.createConversation(title: title, type: type);
  }
}
