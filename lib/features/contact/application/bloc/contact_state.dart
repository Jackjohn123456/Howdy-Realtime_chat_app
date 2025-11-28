part of 'contact_bloc.dart';

sealed class ContactState {}

class InitialContactState extends ContactState{}

class LoadingContactState extends ContactState{}

class LoadedContactState extends ContactState{
  final List<ContactEntity> contactList;

  LoadedContactState({required this.contactList});
}

class ErrorContactState extends ContactState{
  final String message;

  ErrorContactState({required this.message});
}

class AddedContactState extends ContactState{}

class ConversationCreated extends ContactState{
  final String name;
  final String conversationID;

  ConversationCreated({required this.name, required this.conversationID});
}

class RecentContactLoading extends ContactState{}

class RecentContactLoaded extends ContactState{
  final List<ContactEntity> recentContacts;

  RecentContactLoaded({required this.recentContacts});
}

class RecentContactError extends ContactState{
  final String error;

  RecentContactError({required this.error});
}