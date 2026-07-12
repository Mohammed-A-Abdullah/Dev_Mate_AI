
abstract class ChatRepository {
  Future<String>sendMessage(String prompt);
  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
  });

  Future<List<Map<String, dynamic>>> loadMessages(String chatId);
  Future<String> createConversation();
}