import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

class SaveMessageUsecase {
  final ChatRepository repository;

  SaveMessageUsecase({required this.repository});
  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
  }){
    return repository.saveMessage(chatId: chatId, text: text, isUser: isUser);
  }
}