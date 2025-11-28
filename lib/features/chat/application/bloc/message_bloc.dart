import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howdy/core/socket_service.dart';
import 'package:howdy/features/chat/domain/enitities/message_entity.dart';
import 'package:howdy/features/chat/domain/usecases/fetch_message_use_case.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent,MessageState>{

  final FetchMessageUseCase fetchMessageUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> messageList = [];
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _isSocketListenerRegistered = false;

  MessageBloc({required this.fetchMessageUseCase}):super(MessageStateLoading()){
    on<LoadMessagesEvent>(_loadMessages);
    on<SendMessageEvent>(_sendMessage);
    on<ReceiveMessageEvent>(_receiveMessage);
  }

  Future<void> _loadMessages(LoadMessagesEvent event, Emitter<MessageState> emit) async {
    emit(MessageStateLoading());
    final messages =await fetchMessageUseCase.call(conversationId: event.conversationId);
    debugPrint("Loading Messages::::::::::::::::${messages.length}");
    messageList.clear();
    messageList.addAll(messages);
    _socketService.socket.emit('joinConversation',event.conversationId);
    if (!_isSocketListenerRegistered) {
      _socketService.socket.on("newMessage", (data) {
        _isSocketListenerRegistered = true;
        //Step 1 Receive
        debugPrint("New Message::::::");
        debugPrint(data.toString());
        add(ReceiveMessageEvent(message: data));
      },);
    }
    emit(MessageStateLoaded(messages: messageList));
  }

  Future<void> _sendMessage(SendMessageEvent event, Emitter<MessageState> emit) async {
    String userId = await _storage.read(key: "userId" ) ?? "";
    debugPrint("userid::::::::$userId");
    debugPrint("conversationId::::::::${event.conversationId}");
    debugPrint("senderId::::::::${event.senderId}");
    debugPrint("content::::::::${event.content}");
    final newMessage = {
      'conversationId':event.conversationId,
      'senderId':event.senderId,
      'content':event.content,
    };
    _socketService.socket.emit("sendMessage",newMessage);
  }

  Future<void> _receiveMessage(ReceiveMessageEvent event, Emitter<MessageState> emit) async{
    //Step 2 Receive Event Called
    final message = MessageEntity.fromJson(event.message);
    messageList.add(message);
    emit(MessageStateLoaded(messages: messageList));
  }
}