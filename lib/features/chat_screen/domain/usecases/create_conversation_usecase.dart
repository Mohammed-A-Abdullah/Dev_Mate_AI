import '../repositories/chat_repository.dart';

class CreateConversationUseCase {
  final ChatRepository repository;

  CreateConversationUseCase({required this.repository});

  Future<String> call() {
    return repository.createConversation();
  }
}
