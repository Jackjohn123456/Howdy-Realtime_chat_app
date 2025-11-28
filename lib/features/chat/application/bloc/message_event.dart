part of 'message_bloc.dart';

sealed class MessageEvent {
  final String conversationId;

  MessageEvent({required this.conversationId});
}

class LoadMessagesEvent extends MessageEvent{
  LoadMessagesEvent({required super.conversationId});
}

class SendMessageEvent extends MessageEvent{
  final String content;
  final String senderId;
  SendMessageEvent({required super.conversationId,required this.content,required this.senderId});
}

class ReceiveMessageEvent extends MessageEvent{
  final Map<String,dynamic> message;
  ReceiveMessageEvent({super.conversationId = "",required this.message});

}