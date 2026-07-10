import 'package:dev_mate_ai/features/chat_screen/domain/entities/chat_message_model.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit( {required this.sendMessageUsecase}):super(ChatInitial());
  final SendMessageUseCase sendMessageUsecase;
  final List<ChatMessage> messages=[];

  Future<void> sendMessage(String prompt) async {
    if (prompt.trim().isEmpty) return;

    messages.insert(0, ChatMessage(text: prompt, isUser: true));
    emit(ChatLoaded(List.from(messages)));
    emit(ChatLoading());

    try {
      final response = await sendMessageUsecase.call(prompt);

      messages.insert(0, ChatMessage(text: response, isUser: false));
      emit(ChatLoaded(List.from(messages)));
    } catch (e) {
      messages.insert(
        0,
        ChatMessage(text: 'An error occurred: $e', isUser: false),
      );
      emit(ChatError(e.toString()));
      emit(ChatLoaded(List.from(messages)));
    }
  }

  void toggleMessageExpansion(int index) {
    if (index >= 0 && index < messages.length) {
      final message = messages[index];
      messages[index] = message.copyWith(expanded: !message.expanded);
      emit(ChatLoaded(List.from(messages)));
    }
  }
}