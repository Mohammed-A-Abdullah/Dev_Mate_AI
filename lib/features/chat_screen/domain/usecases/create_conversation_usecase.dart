import '../repositories/chat_repository.dart';

class CreateConversationUseCase {
  final ChatRepository repository;

  CreateConversationUseCase({required this.repository});

  Future<String> call({required String title, required String type}) {
    return repository.createConversation(title: title, type: type);
  }
}
