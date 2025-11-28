import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/core/socket_service.dart';
import 'package:howdy/features/conversation/domain/entities/conversation_entity.dart';
import 'package:howdy/features/conversation/domain/usecases/fetch_conversation_use_case.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent,ConversationState>{

  final FetchConversationUseCase fetchConversationUseCase;
  final SocketService _socketService = SocketService();

  ConversationBloc({required this.fetchConversationUseCase}):super(ConversationInitial()){
    on<FetchConversation>(_fetchConversation);
    _initializeSocketListener();
  }

  Future<void> _fetchConversation(FetchConversation event, Emitter<ConversationState> emit) async {
      try {
        emit(ConversationLoading());
        final conversations = await fetchConversationUseCase.call();
        emit(ConversationLoaded(conversations: conversations));
      } on Exception catch (e) {
        // TODO
        emit(ConversationError(error: e.toString()));
      }
  }

  void _initializeSocketListener() {
    _socketService.socket.on("conversationUpdated", (data) {
      add(FetchConversation());
    },);
  }



}