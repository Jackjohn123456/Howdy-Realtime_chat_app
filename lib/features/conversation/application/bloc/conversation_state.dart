part of 'conversation_bloc.dart';

sealed class ConversationState {}

class ConversationInitial extends ConversationState{}

class ConversationError extends ConversationState{
  final String error;

  ConversationError({required this.error});
}

class ConversationLoading extends ConversationState{}

class ConversationLoaded extends ConversationState{
  final List<ConversationEntity> conversations;

  ConversationLoaded({required this.conversations});
}



