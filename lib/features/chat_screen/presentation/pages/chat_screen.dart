import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/custom_chat_text_field.dart';
import '../widgets/custom_loading_progress.dart';
import '../widgets/custom_user_and_bot_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.chatId, this.initialMessages});

  final String? chatId;
  final List<Map<String, dynamic>>? initialMessages;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatCubit>(),
      child: ChatView(chatId: chatId, initialMessages: initialMessages),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key, this.chatId, this.initialMessages});

  final String? chatId;
  final List<Map<String, dynamic>>? initialMessages;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.chatId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ChatCubit>().loadConversation(widget.chatId!);
      });
    }
  }

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(title: 'DevMate AI', needButton: false),
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
