import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

class SaveMessageUsecase {
  final ChatRepository repository;

  SaveMessageUsecase({required this.repository});

  Future<void> saveMessage({
    required String chatId,
    required String text,
    required bool isUser,
    required String type,
    String? title,
  }) {
    return repository.saveMessage(
      chatId: chatId,
      text: text,
      isUser: isUser,
      type: type,
      title: title,
    );
  }
}
