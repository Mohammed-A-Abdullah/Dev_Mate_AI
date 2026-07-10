import 'package:dev_mate_ai/features/chat_screen/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<String> call(String prompt){
    return repository.sendMessage(prompt);
  }
}
