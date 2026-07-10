import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/custom_chat_text_field.dart';
import '../widgets/custom_loading_progress.dart';
import '../widgets/custom_user_and_bot_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        sendMessageUsecase: SendMessageUseCase(
          repository: ChatRepositoryImpl(gemnini: GeminiService()),
        ),
      ),
      child: const ChatView(),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ChatCubit>();
    final state = cubit.state;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(title: 'DevMate AI'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: cubit.messages.length,
                    itemBuilder: (context, index) {
                      final message = cubit.messages[index];
                      return CustomUserAndBotMessage(
                        check: message.isUser,
                        text: message.text,
                        onTap: () => cubit.toggleMessageExpansion(index),
                      );
                    },
                  ),
                ),
                if (state is ChatLoading) const CustomLoadingProgress(),
                const SizedBox(height: 10),
                CustomChatTextField(
                  chatController: _controller,
                  onPressed: () {
                    cubit.sendMessage(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
