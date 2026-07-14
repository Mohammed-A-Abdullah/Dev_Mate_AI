import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

class LoadMessagesUsecase {
  final ChatRepository repository;

  LoadMessagesUsecase({required this.repository});

  Future<List<Map<String, dynamic>>> call(String chatId) {
    return repository.loadMessages(chatId);
  }
}
