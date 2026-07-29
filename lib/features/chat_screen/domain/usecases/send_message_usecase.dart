import 'package:dev_mate_ai/features/chat_screen/domain/entities/chat_message_model.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<String> call(String prompt, List<ChatMessage> history) {
    return repository.sendMessage(prompt, history: history);
  }
}
