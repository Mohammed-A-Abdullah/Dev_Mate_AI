import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String errorMessage;

  const ChatError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
