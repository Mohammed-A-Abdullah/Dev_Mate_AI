import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/entities/chat_message_model.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/save_message_usecase.dart';
import 'package:dev_mate_ai/features/chat_screen/domain/usecases/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_conversation_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.sendMessageUsecase,
    required this.saveMessageUsecase,
    required this.createConversationUseCase,
  }) : super(ChatInitial());

  final SendMessageUseCase sendMessageUsecase;
  final SaveMessageUsecase saveMessageUsecase;
  final CreateConversationUseCase createConversationUseCase;
  final List<ChatMessage> messages = [];
  String? currentChatId;

  Future<void> sendMessage(String prompt) async {
    if (prompt.trim().isEmpty) return;

    final chatTitle = buildConversationTitle(prompt);

    messages.insert(0, ChatMessage(text: prompt, isUser: true));
    currentChatId ??= await createConversationUseCase(
      title: chatTitle,
      type: 'chat',
    );
    await saveMessageUsecase.saveMessage(
      chatId: currentChatId!,
      text: prompt,
      isUser: true,
      type: 'chat',
      title: chatTitle,
    );

    emit(ChatLoaded(List.from(messages)));
    emit(ChatLoading());

    try {
      final response = await sendMessageUsecase.call(prompt);

      messages.insert(0, ChatMessage(text: response, isUser: false));

      await saveMessageUsecase.saveMessage(
        chatId: currentChatId!,
        text: response,
        isUser: false,
        type: 'chat',
      );

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
