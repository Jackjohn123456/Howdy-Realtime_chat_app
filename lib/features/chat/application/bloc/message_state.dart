part of 'message_bloc.dart';

sealed class MessageState {}

class MessageStateLoading extends MessageState{
  MessageStateLoading();
}

class MessageStateLoaded extends MessageState{
  final List<MessageEntity> messages;
  MessageStateLoaded({required this.messages});
}

class MessageStateError extends MessageState{
  final String error;
  MessageStateError({required this.error});
}