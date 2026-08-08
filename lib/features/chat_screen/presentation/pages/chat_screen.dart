import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/chat_message_model.dart';
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
    final local = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: local.chat, needButton: false),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          bottom: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final isTablet = width >= 600;
              final isDesktop = width >= 1024;

              final horizontalPadding = isDesktop
                  ? 0.0
                  : (isTablet ? 8.0 : 15.0);

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 900 : double.infinity,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: BlocBuilder<ChatCubit, ChatState>(
                            builder: (context, state) {
                              final cubit = context.read<ChatCubit>();

                              if (state is ChatLoading &&
                                  cubit.messages.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              List<ChatMessage> currentMessages = [];
                              if (state is ChatLoaded) {
                                currentMessages = state.messages;
                              } else {
                                currentMessages = cubit.messages;
                              }

                              return ListView.builder(
                                reverse: true,
                                itemCount: currentMessages.length,
                                itemBuilder: (context, index) {
                                  final message = currentMessages[index];
                                  return CustomUserAndBotMessage(
                                    check: message.isUser,
                                    text: message.text,
                                    onTap: () =>
                                        cubit.toggleMessageExpansion(index),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        BlocBuilder<ChatCubit, ChatState>(
                          builder: (context, state) {
                            final cubit = context.read<ChatCubit>();
                            if (state is ChatLoading &&
                                cubit.messages.isNotEmpty) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: CustomLoadingProgress(),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),

                        const SizedBox(height: 10),
                        CustomChatTextField(
                          chatController: _controller,
                          onPressed: () {
                            context.read<ChatCubit>().sendMessage(
                              _controller.text,
                            );
                            _controller.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
